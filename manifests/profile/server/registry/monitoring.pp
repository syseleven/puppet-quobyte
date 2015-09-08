class quobyte::profile::server::registry::monitoring(
  $monitoring = hiera('sys11stack::monitoring', false),
  $quobyte_api_service = hiera('quobyte::profile::server::api_service'),
  $quorum = hiera('quobyte::profile::server::registry::quorum', 3),
  $admin_password = false,
) {

  $quobyte_api_simple = regsubst($quobyte_api_service, 'admin:quobyte@', '')

  case $monitoring {
    'sensu': {
      file_line { 'sudo_check_quobyte_registry_device_count':
        path    => '/etc/sudoers',
        line    => 'sensu ALL=(ALL) NOPASSWD: /usr/lib/nagios/plugins/check_quobyte_registry_device_count',
      }

      file {'/usr/lib/nagios/plugins/check_quobyte_registry_device_count':
        ensure  => file,
        mode    => '0550',
        content => template("$module_name/monitoring/check_quobyte_registry_device_count.erb"),
      }
      sensu::check{'quobyte_registry_device_count':
        command => "sudo /usr/lib/nagios/plugins/check_quobyte_registry_device_count $quorum",
        require => File['/usr/lib/nagios/plugins/check_quobyte_registry_device_count'],
      }
    }
    false:  { }
    default: { fail("Only sensu monitoring supported ('$monitoring' given)") }
  }
}
