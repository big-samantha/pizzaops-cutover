class cutover::ssldir ( $ssldir ) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  validate_string($ssldir)
  validate_path($ssldir)
  file { 'ssldir':
    ensure => absent,
    path   => $ssldir,
    force  => true,
  }
}
