class quobyte::profile::client::config {

  file { '/etc/fuse.conf':
    ensure  => file,
    mode    => '0444',
    content => "# Managed by puppet\nuser_allow_other\n",
    require => Package['quobyte-client'],
  }

  file_line { 'quobyte_user_xattr':
    path    => '/etc/quobyte/client.cfg',
    line    => 'fuse_option=user_xattr',
    match   => '^fuse_option',
    require => Package['quobyte-client'],
  }

}
