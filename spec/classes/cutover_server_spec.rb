require 'spec_helper'

describe 'cutover::server' do
  before(:all) do
    @puppetconf_location = '/etc/puppetlabs/puppet/puppet.conf'
  end

  context 'cutover::server class logic' do
    describe 'should enforce the server value in puppet.conf' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :server => 'foo.bar.com',
        :server_section => 'main',
      }}
      let(:facts) {{
        :kernel => 'Linux',
      }}

      it { should compile.with_all_deps }
      it { should contain_ini_setting('server').with(
        'path' => @puppetconf_location,
        'section' => 'main',
        'value' => 'foo.bar.com',
        )
      }
    end
    
    describe 'should fail if server is Windows' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :server => 'foo.bar.com',
        :server_section => 'main',
      }}
      let(:facts) {{
        :osfamily => 'windows',
      }}

      it { should_not compile }
    end

    describe 'should notify if called from external module' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :server => 'foo.bar.com',
        :server_section => 'main',
      }}
      let(:facts) {{
        :kernel => 'Linux',
        :module_name => 'foo',
        :caller_module_name => 'bar'
      }}

      it { should contain_cutover__private_warning('cutover::server') }
    end
  end
end
