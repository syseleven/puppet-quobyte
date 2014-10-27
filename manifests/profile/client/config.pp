class quobyte::profile::client::config {

  file { '/etc/fuse.conf':
    ensure  => file,
    mode    => '0444',
    content => "# Managed by puppet\nuser_allow_other\n",
  }

}
