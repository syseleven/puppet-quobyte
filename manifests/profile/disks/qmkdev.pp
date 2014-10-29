define quobyte::profile::disks::qmkdev (
  $device_type = 'DATA',
) {

  exec { "qmkdev-${name}":
    command  => "qmkdev -t ${device_type} -s \$(uuidgen) ${name}",
    provider => shell,
    path     => ['/sbin/', '/usr/sbin/', '/bin', '/usr/bin'],
    unless   => "test -e ${name}/QUOBYTE_DEV_SETUP",
  }

}
