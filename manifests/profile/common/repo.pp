class quobyte::profile::common::repo(
  $repo_url,
  $repo_key,
  $repo_key_source,
) {

  apt::key { 'quobyte.key':
    key        => $repo_key,
    key_source => $repo_key_source
  }

  apt::source { 'quobyte':
    location    => $repo_url,
    release     => '',
    repos       => './',
    key         => $repo_key,
    include_src => false,
  }

}
