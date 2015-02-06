# == Class: cutover
#
# Class for migrating agents from one puppet master/infrastructure/ca to another.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class cutover (
  $ssldir = $::cutover::params::ssldir,
  $puppet_conf = $::cutover::params::puppet_conf,
  $manage_server = false,
  $manage_ca_server = false,
  $server = nil,
  $server_section = 'main',
  $ca_server = nil,
  $ca_server_section = 'main',
) inherits ::cutover::params {
  validate_bool($manage_server)
  validate_bool($manage_ca_server)
  if ! ($::cutover::manage_server or $::cutover::manage_ca_server) {
    fail('You are not managing the server or ca_server setting')
  }
  if cutover_str2bool($::is_pe_infra) {
    notify { 'pe-agents-only':
      message => 'This module should not be applied to PE infrastructure nodes.',
    }
  }
  else {
    if $manage_server == true { class { 'cutover::server':
        puppet_conf    => $puppet_conf,
        server         => $server,
        server_section => $server_section,
        before         => Class['cutover::ssldir'],
      }
    }

    if $manage_ca_server == true {
      class { 'cutover::ca_server':
        puppet_conf       => $puppet_conf,
        ca_server         => $ca_server,
        ca_server_section => $ca_server_section,
        before            => Class['cutover::ssldir'],
      }
    }

    class { 'cutover::ssldir':
      ssldir => $ssldir,
    }
  }
}
