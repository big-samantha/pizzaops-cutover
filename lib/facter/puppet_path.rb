Facter.add('puppet_path') do
  confine :kernel => 'Linux'
  setcode do
    is_pe = Facter.value('is_pe')
    if is_pe
      path = '/opt/puppet/bin/puppet'
    elsif File.file?('/usr/bin/puppet')
      path = '/usr/bin/puppet'
    else
      which_output = Facter::Util::Resolution.exec('which puppet')
      if which_output.empty?
        path = nil
      else
        path = which_output
      end
    end
    path
  end
end
