class quobyte::profile::disks (
  $diskroles = undef,
) {

  require quobyte::profile::common::tools

  define quobyte_device (
    $diskroles = undef,
  ) {

    if is_hash($diskroles) {
      $device_type = $diskroles[$name]
    }
    else {
      $device_type = 'DATA'
    }

    exec {"prepare-quobyte-device-${name}":
      command => "/usr/local/bin/prepare-quobyte-device -t ${device_type} ${name}",
    }

  }

  $disks = keys($diskroles)

  quobyte_device { $disks:
    diskroles => $diskroles,
  }

}
