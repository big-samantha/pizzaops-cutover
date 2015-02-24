require 'spec_helper'

describe 'cutover::private_warning', :type => :define do
  let :title do
    'foobybaz'
  end

  context 'should warn if $caller_module_name != $module_name' do
    describe 'should contain warning notify resource' do
      it { should contain_cutover__private_warning('foobybaz') }
      it { should contain_notify('foobybaz is private and should not be called directly.') }
    end
  end
end
