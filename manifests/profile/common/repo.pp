class quobyte::profile::common::repo(
  $repo_url,
  $repo_key,
  $repo_key_source,
) {

  include apt

  apt::key { 'quobyte.key':
    id        => $repo_key,
    source => $repo_key_source
  }

  apt::source { 'quobyte':
    location    => $repo_url,
    release     => '',
    repos       => './',
    key         => $repo_key,
  }

}
