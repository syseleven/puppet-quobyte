class quobyte::role::server_bootstrap (
  $bootstrap_device = hiera('quobyte::profile::disks::bootstrap_device', undef)
)
{

class { 'quobyte::profile::client':
  monitoring => false,
}

class { 'quobyte::profile::server':
  monitoring => false,
}

include quobyte::profile::disks

# Only create volumes on the node bootstrapping the cluster in order to avoid
# race conditions on volume/volume config creation:

if $bootstrap_device {
  include quobyte::profile::volumes
}

}
