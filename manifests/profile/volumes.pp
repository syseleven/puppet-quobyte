# Creates Quobyte volumes and their configurations. It is best to only run this on one machine to avoid race conditions.
class quobyte::profile::volumes (
  $volumes = {},
  $cinder_stripe_width = 5,
  $glance_stripe_width = 1,
  $nova_stripe_width = 5,
  $cinder_cache_size = 50,
  $nova_cache_size = 50,
  ) {
    # Add an appropriately named file (see below) and an entry to this list for new volume configs.
    $volume_configs = ['BASE', 'cinder', 'nova', 'glance']

    $volumes_keys = keys($volumes)

    quobyte_volume_configs{ $volume_configs: }

    quobyte_volumes{ $volumes_keys:
      volumes => $volumes,
      require => Quobyte_volume_configs[$volume_configs],
    }


    # Creates multiple Quobyte volumes configurations from list.

    define quobyte_volume_configs(
      ) {
        quobyte_volume_config { $name:
          content => template("$module_name/quobyte_volume_config_$name"),
        }
      }


    # Creates multiple Quobyte volumes from configuration hash.

    define quobyte_volumes(
      $volumes,
    ) {
      if $volumes['mode'] {
        $mode = $volumes[$name]['mode']
      } else {
        $mode = undef
      }

      if $volumes['config'] {
        $config = $volumes[$name]['config']
      } else {
        $config = undef
      }

      quobyte_volume{$name:
        user    => $volumes[$name]['user'],
        group   => $volumes[$name]['group'],
        mode    => $mode,
        config  => $config,
      }
    }
  }
