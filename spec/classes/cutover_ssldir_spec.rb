require 'spec_helper'

describe 'cutover::ssldir' do
  before(:all) do
    @ssldir_location = '/etc/puppetlabs/puppet/ssl'
  end

  context 'cutover::ssldir class logic' do
    describe 'should enforce that the ssldir be absent' do
      let(:params) {{
        :ssldir => @ssldir_location,
      }}
      let(:facts) {{
        :kernel => 'Linux',
      }}

      it { should compile.with_all_deps }
      it { should contain_service('pe-puppet') }

      it { should contain_file('ssldir').with(
        'path' => @ssldir_location
        )
      }
    end

    describe 'should notify if called from external module' do
      let(:params) {{
        :ssldir => '/foo/bar/baz',
      }}
      let(:facts) {{
        :kernel => 'Linux',
      }}

      it { should contain_cutover__private_warning('cutover::ssldir') }
    end
  end
end
