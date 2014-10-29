class quobyte::profile::disks (
  $metadatadisks = undef,
  $datadisks = undef,
) {

  require quobyte::profile::common::sysfsutils
  require quobyte::profile::common::tools

  define quobyte_device (
    $device_type = 'DATA',
  ) {

    $base_device = "/dev/${name}"
    $part_device = "/dev/${name}1"
    $mountpoint  = "/mnt/${name}1"

    # HACK: Implement variable indirection
    $rotational_fact = "::blockdevice_${name}_rotational"
    $rotational = inline_template("<%= scope.lookupvar(rotational_fact) %>")
    if $rotational == '1' {
      $mountopts = 'noatime,nodiratime,largeio,swalloc,allocsize=131072k'
    } else {
      $mountopts = 'noatime,nodiratime,discard'
    }
    $scheduler_fact = "::blockdevice_${name}_scheduler"
    $scheduler = inline_template("<%= scope.lookupvar(scheduler_fact) %>")

    quobyte::profile::disks::partition { $name: } ->
    quobyte::profile::disks::xfs { $part_device: } ->
    file { $mountpoint:
      ensure => directory,
    } ->
    mount { $mountpoint:
      ensure  => mounted,
      atboot  => true,
      device  => $part_device,
      fstype  => 'xfs',
      options => $mountopts,
      dump    => 0,
      pass    => 2,
    } ->
    quobyte::profile::disks::qmkdev { $mountpoint:
      device_type => $device_type,
    } ->
    quobyte::profile::disks::qtags { $mountpoint:
      rotational => $rotational,
    }

    # If the device has a scheduler (not a virtual device),
    # set a very long queue length for Quobyte performance
    if $scheduler != 'none' {
      file { "/etc/sysfs.d/${name}_queuelength.conf":
        ensure  => file,
        mode    => '0444',
        content => "# Managed by Puppet\nblock/${name}/queue/nr_requests = 4096\n",
        notify  => Exec['sysfsutils-restart'],
      }
    }

  }

  if $metadatadisks {
    quobyte_device { $metadatadisks:
      device_type => 'METADATA',
    }
  }

  if $datadisks {
    quobyte_device { $datadisks:
      device_type => 'DATA',
    }
  }

}
