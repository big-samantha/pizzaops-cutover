class cutover::ssldir ( $ssldir ) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  validate_string($ssldir)
  validate_path($ssldir)

  if ! ($::cutover::manage_server or $::cutover::manage_ca_server) {
    fail('You are not managing the server or ca_server setting')
  }

  if ! defined(Service['pe-puppet']) {
    service { 'pe-puppet': }
  }

  file { 'ssldir':
    ensure => absent,
    path   => $ssldir,
    force  => true,
    notify => Service['pe-puppet'],
  }
}
