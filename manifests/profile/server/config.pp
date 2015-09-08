class quobyte::profile::server::config (
  $registry,
  $api_service = 'http://127.0.0.1:7860',
  $smtp_host = 'localhost',
  $smtp_port = 25,
  $smtp_sender = 'quobyte@localhost',
  $keystone_hostname = '',
  $keystone_port = 35357,
  $keystone_userid = '',
  $keystone_password = '',
) {

  file { '/etc/quobyte/host.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'quobyte',
    mode    => '0444',
    content => template("${module_name}/host.cfg.erb"),
  }

  file { '/etc/quobyte/system.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'quobyte',
    mode    => '0440',
    content => template("${module_name}/system.cfg.erb"),
  }

}
