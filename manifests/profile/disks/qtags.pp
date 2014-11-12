define quobyte::profile::disks::qtags (
  $rotational = '1',
) {

  if $rotational == '1' {
    exec { "add-hdd-tag-$name":
      command => "/usr/local/bin/quobyte_device_settings -u $quobyte::profile::server::api_service --tags hdd $name && touch $name/.tagged",
      onlyif  => "/usr/bin/test -f $name/QUOBYTE_DEV_ID",
      creates => "$name/.tagged",
    }
  } else {
    exec { "add-ssd-tag-$name":
      command => "/usr/local/bin/quobyte_device_settings -u $quobyte::profile::server::api_service --tags ssd $name && touch $name/.tagged",
      onlyif  => "/usr/bin/test -f $name/QUOBYTE_DEV_ID",
      creates => "$name/.tagged",
    }
  }

}
