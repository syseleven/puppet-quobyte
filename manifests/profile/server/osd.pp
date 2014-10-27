class quobyte::profile::server::osd (
  $run_service = true,
) {

  service { 'quobyte-osd':
    ensure => $run_service,
    enable => $run_service,
  }

}
