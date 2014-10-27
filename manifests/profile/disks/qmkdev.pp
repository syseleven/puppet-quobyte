define quobyte::profile::disks::qmkdev () {

  exec { "qmkdev-${name}":
    command  => "qmkdev -t DATA -s \$(uuidgen) ${name}",
    provider => shell,
    path     => ['/sbin/', '/usr/sbin/', '/bin', '/usr/bin'],
    unless   => "test -e ${name}/QUOBYTE_DEV_SETUP",
  }

}
