define quobyte::profile::disks::qtypes (
  $types = [],
) {

  $device_types = join($types, ',')

  exec { "add-device-types-$name":
    command => "/usr/local/bin/quobyte_device_settings -u $quobyte::profile::server::api_service --types $device_types $name && touch $name/.typed",
    onlyif  => "/usr/bin/test -f $name/QUOBYTE_DEV_ID",
    creates => "$name/.typed",
  }

}
