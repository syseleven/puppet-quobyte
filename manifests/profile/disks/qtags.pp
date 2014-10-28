define quobyte::profile::disks::qtags (
  $rotational = "1",
) {

  if $rotational == "1" {
    exec { "add-hdd-tag-$name":
      command => "/usr/local/bin/quobyte_device_tags -u $quobyte::profile::server::api_service -t hdd $name && touch $name/.tagged",
      creates => "$name/.tagged",
    }
  } else {
    exec { "add-ssd-tag-$name":
      command => "/usr/local/bin/quobyte_device_tags -u $quobyte::profile::server::api_service -t ssd $name && touch $name/.tagged",
      creates => "$name/.tagged",
    }
  }

}
