class quobyte::profile::client::monitoring (
  $monitoring = hiera('sys11stack::monitoring', false),
) {
  case $monitoring {
    'sensu':  {
      ensure_packages(['python3-html5lib', 'python3-requests'])

      file {'/usr/lib/nagios/plugins/check_quobyte_client_versions':
        ensure => file,
        mode   => '0555',
        source => "puppet:///modules/$module_name/monitoring/check_quobyte_client_versions",
      }->
      sensu::check{'quobyte_client_versions':
        command => '/usr/lib/nagios/plugins/check_quobyte_client_versions',
      }
    }
    false:  { }
    default: { fail("Only sensu monitoring supported ('$monitoring' given)") }
  }
}
