class quobyte::profile::common::tools () {

  ensure_packages(['xfsprogs', 'sysfsutils', 'python-jsonrpclib'])

  file { '/usr/local/bin/quobyte_device_tags':
    mode   => '0555',
    source => "puppet:///modules/$module_name/quobyte_device_tags",
  }

}
