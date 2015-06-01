# Creates Quobyte volumes and their configurations. It is best to only run this on one machine to avoid race conditions.
class quobyte::profile::volumes (
  $volumes = {},
  $public_ip = hiera('quobyte::profile::server::api::public_ip'),
  $api_port = hiera('quobyte::profile::server::api::api_port'),
  ) {
    $api_url = "http://${public_ip}:${api_port}"

    # Add an appropriately named file (see below) and an entry to this list for new volume configs.
    $volume_configs = ['BASE', 'Cinder', 'Nova']

    $volumes_keys = keys($volumes)

    quobyte_volume_configs{ $volume_configs: }

    quobyte_volumes{ $volumes_keys:
      volumes => $volumes,
      api_url => $api_url,
      require => Quobyte_volume_configs[$volume_configs],
    }


    # Creates multiple Quobyte volumes configurations from list.

    define quobyte_volume_configs(
      ) {
        quobyte_volume_config { $name:
          content => file("$module_name/quobyte_volume_config_$name"),
        }
      }


    # Creates multiple Quobyte volumes from configuration hash.

    define quobyte_volumes(
      $volumes,
      $api_url,
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
        api_url => $api_url,
      }
    }
  }
