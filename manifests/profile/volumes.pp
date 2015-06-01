# Creates Quobyte volumes and their configurations.
class quobyte::profile::volumes (
  $volumes = {},
  $api_url = "http://127.0.0.1:17860",
  ) {

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
          content => file("puppet:///modules/$module_name/quobyte_volume_config_$name"),
        }
      }


    # Creates multiple Quobyte volumes from configuration hash.

    define quobyte_volumes(
      $volumes,
      $api_url,
    ) {
      if $volumes['mode'] {
        $mode = $volumes['mode']
      } else {
        $mode = undef
      }

      if $volumes['config'] {
        $config = $volumes['config']
      } else {
        $config = undef
      }

      quobyte_volume{$name:
        user    => $volumes['user'],
        group   => $volumes['group'],
        mode    => $mode,
        config  => $config,
        api_url => $api_url,
      }
    }
  }
