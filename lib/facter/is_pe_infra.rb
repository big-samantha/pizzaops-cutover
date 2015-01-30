Facter.add('is_pe_infra') do
  confine :osfamily => 'RedHat'
  setcode do
    is_pe_infra = nil
    packages = ['pe-puppetdb','pe-puppet-server','pe-puppet-dashboard-workers','pe-activemq','pe-httpd']
    packages.each do |package|
      is_pe_infra = system("yum list installed #{package}  &> /dev/null")
      break if is_pe_infra == true
    end
    is_pe_infra
  end
end
