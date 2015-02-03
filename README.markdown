# pizzaops-cutover

This is a puppet module for cutting an agent over from one master/ca infrastructure to another.

It depends on recent versions of `puppetlabs-inifile` and `puppetlabs-stdlib`.

Essentially it does the following:

* Optionally changes the `server` parameter in `puppet.conf` on the agent.
* Optionally changes the `caserver` parameter in `puppet.conf` on the agent.`
* ALWAYS removes the ssldir on the agent.
* Finally, restarts the puppet agent.

## Usage

Install this module on the "old" master, e.g. the master you are moving agents *AWAY* from.

Classify the agents you would like to migrate as per the below examples.

### Minimal use case:

```puppet
class { 'cutover':
  manage_server => true,
  server        => 'newmaster.puppetlabs.com'
}
```

The above will change the agent's `server` paramter from whatever it currently, to `newmaster.puppetlabs.com`, and then remove the ssldir.

### Maximal use case:

```puppet
class { 'cutover':
  manage_server     => true,
  server            => 'newmaster.puppetlabs.com',
  server_section    => 'main'
  manage_ca_server  => true,
  ca_server         => 'newcaserver.puppetlabs.com',
  ca_server_section => 'agent',
  ssldir            => '/weird/unusual/ssldir/location',
  puppet_conf       => '/werd/unusual/location/for/puppet.conf',
}
```

The above will:

 * Make the `sever` parameter in the `main` section of `puppet.conf` `newmaster.puppetlabs.com`
 * Make the `ca_server` parameter of the `agent` section of `puppet.conf` `newcaserver.puppetlabs.com`
 * Assume the `ssldir` is `/weird/unusual/ssldir/location` and remove it.
 * Assume that `puppet.conf` is located at `/werd/unusual/location/for/puppet.conf`, and make changes to the values in those files as per the above.

## Additional Details

`manage_server` and `manage_ca_server` both default to false. If you classify a node with this class and do not set either of them to true, all it will do is blow away the SSL dir.

Both the `ssldir` and `puppet_conf` parameters have reasonable defaults for both PE and POSS, via logic in params.

If neither `manage_server` nor `manage_ca_server` are set to true, the `cutover::ssldir` class will abort catalog compilation.
