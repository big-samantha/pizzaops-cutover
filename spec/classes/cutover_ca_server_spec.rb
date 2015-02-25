require 'spec_helper'

describe 'cutover::ca_server' do
  before(:all) do
    @puppetconf_location = '/etc/puppetlabs/puppet/puppet.conf'
  end

  context 'cutover::ca_server class logic' do
    describe 'should enforce the ca_server value in puppet.conf' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :ca_server => 'foo.bar.com',
        :ca_server_section => 'main',
      }}
      let(:facts) {{
        :kernel => 'Linux',
      }}

      it { should compile.with_all_deps }
      it { should contain_ini_setting('ca_server').with(
        'path' => @puppetconf_location,
        'section' => 'main',
        'value' => 'foo.bar.com',
        )
      }
    end
    
    describe 'should notify if called from external module' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :ca_server => 'foo.bar.com',
        :ca_server_section => 'main',
      }}
      let(:facts) {{
        :kernel => 'Linux',
      }}

      it { should contain_cutover__private_warning('cutover::ca_server') }
    end
  end
end

