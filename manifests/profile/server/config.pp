class quobyte::profile::server::config (
  $dir_service,
) {

  file { '/etc/quobyte/host.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'quobyte',
    mode    => '0440',
    content => "# Managed by Puppet\ndir_service=${dir_service}\ndebug.level=6\n",
  }

}
