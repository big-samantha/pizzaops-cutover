class cutover::ssldir ( $ssldir ) {
  cutover::private_warning { 'cutover::ssldir' }
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
