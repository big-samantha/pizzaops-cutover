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

    describe 'should inlude cutover::server and cutover::ssldir if manage_server == true' do
      let(:params) {{
        :manage_server => true,
        :server => 'foo.bar.com',
      }}
      let(:facts) {{
        :kernel => 'Linux',
        :is_pe_infra => false,
      }}

      it { should compile.with_all_deps }
      
      it { should_not contain_notify('pe-agents-only') }
      it { should contain_class('cutover::server') }
      it { should contain_class('cutover::ssldir') }
    end

    describe 'should include cutover::ca_server and cutover::ssldir if manage_ca_server == true' do
      let(:params) {{
        :manage_ca_server => true,
        :ca_server => 'foo.bar.com',
      }}
      let(:facts) {{
        :kernel => 'Linux',
        :is_pe_infra => false,
      }}

      it { should compile.with_all_deps }
      
      it { should_not contain_notify('pe-agents-only') }
      it { should contain_class('cutover::ca_server') }
      it { should contain_class('cutover::ssldir') }
    end

    describe 'should fail catalog compilation if neither manage_server nor manage_ca_server is true' do
      let(:params) {{
      }}
      let(:facts) {{
        :kernel => 'Linux',
        :is_pe_infra => false,
      }}

      it { should_not compile }
    end
  end
end
