class quobyte::profile::disks::qbootstrap (
  $device = undef,
) {

  if $device {
    exec { "qbootstrap-${device}":
      command  => "qbootstrap -s \$(uuidgen) ${device}",
      provider => shell,
      path     => ['/sbin/', '/usr/sbin/', '/bin', '/usr/bin'],
      unless   => "test -e ${device}/QUOBYTE_DEV_SETUP",
      before   => "qmkdev-${$device}"
    }
  }

}
