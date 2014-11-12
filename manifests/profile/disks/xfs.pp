define quobyte::profile::disks::xfs (
  $isize = 1024,
) {

  require quobyte::profile::common::tools

  $target_device = $name

  exec { "mkfs-${name}":
    command => "mkfs.xfs -isize=${isize} ${target_device}",
    path    => ['/sbin/', '/usr/sbin/'],
    unless  => "xfs_admin -l ${target_device}",
  }

}
