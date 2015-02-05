class cutover::ssldir ( $ssldir ) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  validate_string($ssldir)
  validate_absolute_path($ssldir)
  if $::osfamily == 'windows' {
    fail('Cutover module currently doesn\'t support Windows.')
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
