class cutover::server (
  $puppet_conf,
  $server,
  $server_section,
) {
  cutover::private_warning { 'cutover::server': }
  validate_string($puppet_conf)
  validate_absolute_path($puppet_conf)
  validate_string($server)
  validate_string($server_section)

  ini_setting { 'server':
    ensure  => present,
    path    => $puppet_conf,
    section => $server_section,
    setting => 'server',
    value   => $server,
  }
}
