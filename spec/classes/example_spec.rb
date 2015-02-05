#require 'spec_helper'
#
#describe 'cutover' do
#  context 'supported operating systems' do
#    ['Debian', 'RedHat'].each do |osfamily|
#      describe "cutover class without any parameters on #{osfamily}" do
#        let(:params) {{ }}
#        let(:facts) {{
#          :osfamily => osfamily,
#        }}
#
#        it { should compile.with_all_deps }
#
#        it { should contain_class('cutover::params') }
#        it { should contain_class('cutover::install').that_comes_before('cutover::config') }
#        it { should contain_class('cutover::config') }
#        it { should contain_class('cutover::service').that_subscribes_to('cutover::config') }
#
#        it { should contain_service('cutover') }
#        it { should contain_package('cutover').with_ensure('present') }
#      end
#    end
#  end
#
#  context 'unsupported operating system' do
#    describe 'cutover class without any parameters on Solaris/Nexenta' do
#      let(:facts) {{
#        :osfamily        => 'Solaris',
#        :operatingsystem => 'Nexenta',
#      }}
#
#      it { expect { should contain_package('cutover') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
#    end
#  end
#end
