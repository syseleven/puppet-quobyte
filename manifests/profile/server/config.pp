class quobyte::profile::server::config (
  $registry,
  $smtp_host = 'localhost',
  $smtp_port = 25,
  $smtp_sender = 'quobyte@localhost',
  $keystone_hostname = '',
  $keystone_port = 35357,
  $keystone_user_id = '',
  $keystone_password = '',
) {

  file { '/etc/quobyte/host.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'quobyte',
    mode    => '0444',
    content => "# Managed by Puppet\nregistry=${registry}\ndebug.level=6\n",
  }

  file { '/etc/quobyte/system.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'quobyte',
    mode    => '0440',
    content => template("${module_name}/system.cfg.erb"),
  }

}
