class cutover::params {
  # Windows paths the same for PE and POSS, and for both the 32 and 64 bit agent.
  # For all other platforms, all of which are *nix of some kind, we 
  # differentiate between PE and POSS paths.
  if $::kernel == 'windows' {
    $ssldir = 'C:/ProgramData/PuppetLabs/puppet/etc/ssl'
    $puppet_conf = 'C:/ProgramData/PuppetLabs/puppet/etc/puppet.conf'
  }
  elsif cutover_str2bool($::is_pe) {
    $ssldir = '/etc/puppetlabs/puppet/ssl'
    $puppet_conf = '/etc/puppetlabs/puppet/puppet.conf'
  }
  else {
    $ssldir = '/var/lib/puppet/ssl'
    $puppet_conf = '/etc/puppet/puppet.conf'
  }
}
