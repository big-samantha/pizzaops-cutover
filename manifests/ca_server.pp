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
  if $::osfamily == 'windows' {
    fail('Cutover module currently doesn\'t support Windows.')
  }
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  ini_setting { 'ca_server':
    ensure  => present,
    path    => $puppet_conf,
    section => $ca_server_section,
    setting => 'ca_server',
    value   => $ca_server,
  }
}
