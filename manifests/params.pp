class cutover::params {
  if str2bool($::is_pe) {
    $ssldir = '/etc/puppetlabs/puppet/ssl'
    $puppet_conf = '/etc/puppetlabs/puppet/puppet.conf'
  }
  else {
    $ssldir = '/etc/puppet/ssl'
    $puppet_conf = '/etc/puppet/puppet.conf'
  }

}
