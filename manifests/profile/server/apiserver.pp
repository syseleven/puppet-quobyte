class quobyte::profile::server::apiserver (
  $run_service = true,
) {

  service { 'quobyte-api':
    ensure => $run_service,
    enable => $run_service,
  }

}
