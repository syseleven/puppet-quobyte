# Sets the public_ip directive in a Quobyte service configuration file.
define quobyte::resources::public_ip (
  $public_ip = undef,
) {

  if ! $public_ip {
    fail('Parameter public_ip must be provided')
  }

  if $public_ip {
    file_line { "${name}-public_ip":
      path   => $name,
      line   => "public_ip = $public_ip",
    }

  }
}
