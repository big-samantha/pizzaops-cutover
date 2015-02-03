class cutover::params {
  if ($::is_pe == true) or ($::is_pe == 'true') {
    $ssldir = '/etc/puppetlabs/puppet/ssl'
    $puppet_conf = '/etc/puppetlabs/puppet/puppet.conf'
  }
  else {
    $ssldir = '/etc/puppet/ssl'
    $puppet_conf = '/etc/puppet/puppet.conf'
  }

}
