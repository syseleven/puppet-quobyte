class quobyte::profile::common::tools () {

  ensure_packages(['gdisk', 'xfsprogs', 'python3-pyudev'])

  file { '/usr/local/bin/prepare-quobyte-device':
    ensure => file,
    source => "puppet:///modules/$module_name/prepare-quobyte-device",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
