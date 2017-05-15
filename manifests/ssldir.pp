#
#
#
class cutover::ssldir ( $ssldir ) {
  cutover::private_warning { 'cutover::ssldir': }
  validate_string($ssldir)
  validate_absolute_path($ssldir)

  if $::puppetversion =~ /^(2|3)\./ {
    $service_name = 'pe-puppet'
  }
  else {
    $service_name = 'puppet'
  }

  if ! defined(Service[$service_name]) {
    service { $service_name: }
  }

  file { 'ssldir':
    ensure => absent,
    path   => $ssldir,
    force  => true,
    notify => Service[$service_name],
  }
}
