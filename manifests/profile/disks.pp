class quobyte::profile::disks (
  $diskroles = undef,
  $bootstrap_device = undef,
  $data_disks_by_model = undef,
) {

  require quobyte::profile::common::tools

  exec { "increase-storage-queuedepth":
    command => "/usr/local/bin/increase-storage-queuedepth",
  }

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
      require => Package['quobyte-server'],
    }

  }

  if $diskroles {
    $disks = keys($diskroles)

    quobyte_device { $disks:
      diskroles => $diskroles,
    }
  }

  if $bootstrap_device {
    exec {"prepare-quobyte-bootstrap-device":
      command => "/usr/local/bin/prepare-quobyte-device -t REGISTRY -b ${bootstrap_device}",
      require => Package['quobyte-server'],
    }
  }

  define quobyte_data_device() {
    exec {"prepare-quobyte-device-${name}":
      command => "/usr/local/bin/prepare-quobyte-device -t DATA ${name}",
      require => Package['quobyte-server'],
    }
  }

  if $data_disks_by_model {
    validate_array($data_disks_by_model)
    $disks_real = get_devices_by_model($data_disks_by_model)
    quobyte_data_device { $disks_real: }
  }
}
