Facter.add('is_pe_infra') do
  confine :kernel => 'Linux'
  setcode do
    puppet_path = Facter.value('puppet_path')
    is_pe_infra = nil
    ensurevalue = nil
    packages = ['pe-puppetdb','pe-puppet-server','pe-puppet-dashboard-workers','pe-activemq','pe-httpd']
    packages.each do |package|
      ensurevalue = Facter::Util::Resolution.exec("#{puppet_path} resource package #{package} 2> /dev/null | grep absent")
      break if ensurevalue.nil? || ensurevalue.empty? 
    end
    if ensurevalue.nil? || ensurevalue.empty?
      is_pe_infra = true
    else
      is_pe_infra = false
    end
    is_pe_infra
  end
end
