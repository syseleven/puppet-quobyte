class quobyte::profile::disks::qbootstrap (
  $device = undef,
) {

  $mountpoint  = "/mnt/${device}1"

  if $device {
    exec { "qbootstrap-${mountpoint}":
      command  => "qbootstrap -s \$(uuidgen) ${mointpoint}",
      provider => shell,
      path     => ['/sbin/', '/usr/sbin/', '/bin', '/usr/bin'],
      unless   => "test -e ${mountpoint}/QUOBYTE_DEV_SETUP",
      before   => [Exec["qmkdev-$mountpoint"], Service['quobyte-api']],
    }
  }

}
