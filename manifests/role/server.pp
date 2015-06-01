class quobyte::role::server (
  $bootstrap_device = hiera('quobyte::profile::disks::qbootstrap::device', undef)
)
{

include quobyte::profile::client
include quobyte::profile::disks
include quobyte::profile::server

# Only create volumes on the node bootstrapping the cluster in order to avoid
# race conditions on volume/volume config creation:

if $bootstrap_device {
  include quobyte::profile::volumes
}

Class['quobyte::profile::disks'] -> Class['quobyte::profile::server']

}
