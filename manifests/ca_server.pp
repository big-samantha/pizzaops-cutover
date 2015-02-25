class cutover::ca_server (
  $puppet_conf,
  $ca_server,
  $ca_server_section,
) {
  cutover::private_warning { 'cutover::ca_server': }
  validate_string($puppet_conf)
  validate_absolute_path($puppet_conf)
  validate_string($ca_server)
  validate_string($ca_server_section)
  ini_setting { 'ca_server':
    ensure  => present,
    path    => $puppet_conf,
    section => $ca_server_section,
    setting => 'ca_server',
    value   => $ca_server,
  }
}
