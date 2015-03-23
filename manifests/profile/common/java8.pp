class quobyte::profile::common::java8 {

  include apt

  apt::key { 'webupd8team':
    key => '7B2C3B0889BF5709A105D03AC2518248EEA14886',
  }->
  apt::ppa { 'ppa:webupd8team/java': }->
  package { 'oracle-java8-installer':
    responsefile => '/var/cache/apt/oracle-java8-installer.preseed',
    require      => File['/var/cache/apt/oracle-java8-installer.preseed'],
  }

  file { '/var/cache/apt/oracle-java8-installer.preseed':
    ensure  => file,
    content => "# Managed by Puppet\noracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true\n",
  }

  file { '/etc/default/quobyte':
    ensure => file,
    source => "puppet:///modules/$module_name/default_quobyte"
  }

}
