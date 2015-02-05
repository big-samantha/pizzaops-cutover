require 'spec_helper'

describe 'cutover' do
  context 'cutover class logic' do
    describe 'should do nothing but notify if $::is_pe_infra == true' do
      let(:params) {{
        :manage_server => true,
        :server => 'foo.bar.com',
      }}
      let(:facts) {{
        :kernel => 'Linux',
        :is_pe_infra => true,
      }}

      it { should compile.with_all_deps }

      it { should contain_notify('pe-agents-only') }

      it { should_not contain_class('cutover::ca_server') }
      it { should_not contain_class('cutover::server') }
      it { should_not contain_class('cutover::ssldir') }
    end
  end
end
