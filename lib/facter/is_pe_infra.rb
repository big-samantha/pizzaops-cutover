require 'puppet'
Facter.add('is_pe_infra') do
  confine :kernel => 'Linux'
  begin 
    Module.const_get('Puppet')
    setcode do
      packages_pe = ['pe-puppetdb','pe-puppetserver','pe-puppet-dashboard-workers','pe-activemq','pe-httpd']
      packages_all = Puppet::Type.type(:package).instances.map { |package| package.title }
      packages_pe_installed = packages_all & packages_pe

      if packages_pe_installed.length == 0
        false
      else
        true
      end
    end
  rescue NameError => e
    setcode do
      # We assume true if the fact logic fails becaue if this returns nil when it shouldn't it will be Very Bad(tm) for you.
      true
    end
  end
end
