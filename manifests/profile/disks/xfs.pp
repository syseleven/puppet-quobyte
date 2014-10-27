define quobyte::profile::disks::xfs (
  $isize = 1024,
) {

  require quobyte::profile::common::xfsprogs

  $target_device = $name

  exec { "mkfs-${name}":
    command => "mkfs.xfs -f -isize=${isize} ${target_device}",
    path    => ['/sbin/', '/usr/sbin/'],
    require => Class['quobyte::profile::common::xfsprogs'],
    unless  => "xfs_admin -l ${target_device}",
  }

}
