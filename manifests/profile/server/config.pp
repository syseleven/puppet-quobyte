class quobyte::profile::server::config (
  $registry,
) {

  file { '/etc/quobyte/host.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'quobyte',
    mode    => '0444',
    content => "# Managed by Puppet\nregistry=${registry}\ndebug.level=6\n",
  }

}
