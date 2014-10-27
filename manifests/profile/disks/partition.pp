define quobyte::profile::disks::partition () {

  require quobyte::profile::common::gdisk

  exec { "sgdisk-${name}":
    command  => "sgdisk -Z /dev/${name} && sgdisk -n 1:0:0 /dev/${name}",
    provider => shell,
    path     => ['/sbin/', '/usr/sbin/'],
    require  => Class['quobyte::profile::common::gdisk'],
    unless   => "blkid /dev/${name}1",
  }

}
