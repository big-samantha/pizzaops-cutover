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

Both the `ssldir` and `puppet_conf` parameters have reasonable defaults for both PE and POSS, via logic in params.

If neither `manage_server` nor `manage_ca_server` are set to true, the `cutover::ssldir` class will abort catalog compilation, because just blowing away the `ssldir` on its own isn't useful. If you need to do that for whatever reason, it's one file resource.

You will get an error like this one at the end of the run, because once the ssldir is gone the agent cannot submit a report to the original master:

```
Error: Could not send report: Error 500 on SERVER: <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>500 Internal Server Error</title>
</head><body>
<h1>Internal Server Error</h1>
<p>The server encountered an internal error or
misconfiguration and was unable to complete
your request.</p>
<p>Please contact the server administrator,
 root@localhost and inform them of the time the error occurred,
and anything you might have done that may have
caused the error.</p>
<p>More information about this error may be available
in the server error log.</p>
<hr>
<address>Apache Server at pe-323-master.puppetdebug.vlan Port 8140</address>
</body></html>
```
