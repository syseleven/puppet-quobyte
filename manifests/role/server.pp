class quobyte::role::server (
  $bootstrap_device = hiera('quobyte::profile::disks::bootstrap_device', undef)
)
{

class { 'quobyte::profile::client':
  monitoring => true,
}

include quobyte::profile::disks

class { 'quobyte::profile::server':
  monitoring => true,
}

# Only create volumes on the node bootstrapping the cluster in order to avoid
# race conditions on volume/volume config creation:

if $bootstrap_device {
  include quobyte::profile::volumes
}

Class['quobyte::profile::disks'] -> Class['quobyte::profile::server']

}
