# pizzaops-cutover

This is a puppet module for cutting an agent over from one master/ca infrastructure to another. It currently supports all operating systems that Puppet Enterprise supports, and should also work with Puppet Open Source.

It depends on recent versions of `puppetlabs-inifile` and `puppetlabs-stdlib`.

Essentially it does the following:

* Optionally changes the `server` parameter in `puppet.conf` on the agent.
* Optionally changes the `ca_server` parameter in `puppet.conf` on the agent.
* ALWAYS removes the ssldir on the agent.
* Finally, restarts the puppet agent.

## Usage

Install this module on the "old" master, e.g. the master you are moving agents *AWAY* from.

Classify the agents you would like to migrate as per the below examples.

**Note:** This code must be enforced after all other Puppet code, or you may experience cert issues. My recommendation would be to run this in a [stage](https://docs.puppetlabs.com/puppet/latest/reference/lang_run_stages.html) that runs after all other stages.

### Minimal use case:

```puppet
stage { 'cutover':
  require => Stage['main'],
}

class { 'cutover':
  manage_server => true,
  server        => 'newmaster.puppetlabs.com',
  stage         => 'cutover',
}
```

The above will change the agent's `server` paramter from whatever it currently, to `newmaster.puppetlabs.com`, and then remove the ssldir.

### Maximal use case:

```puppet
stage { 'cutover':
  require => Stage['main'],
}

class { 'cutover':
  manage_server     => true,
  server            => 'newmaster.puppetlabs.com',
  server_section    => 'main'
  manage_ca_server  => true,
  ca_server         => 'newcaserver.puppetlabs.com',
  ca_server_section => 'agent',
  ssldir            => '/weird/unusual/ssldir/location',
  puppet_conf       => '/werd/unusual/location/for/puppet.conf',
  stage             => 'cutover'
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
```

You may also experience other random resource errors, depending on what order the resources are enforced in, as once the ssldir is removed,  the agent will no longer be able to contact the original master for things like `puppet:///`-style URIs in file resources, etc. You can avoid this by assigning the cutover class to a stage that is enforced after the main stage. For more on stages, see <https://docs.puppetlabs.com/puppet/latest/reference/lang_run_stages.html>.
