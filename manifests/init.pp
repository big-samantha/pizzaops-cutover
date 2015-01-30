# == Class: cutover
#
# Full description of class cutover here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class cutover (
  $ssldir = $::cutover::params::package_name,
  $master_fqdn = $::cutover::params::service_name,
) inherits ::cutover::params {


}
