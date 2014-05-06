require 'spec_helper'
require 'active_support/inflector'

describe 'FactoryGirl' do
  FactoryGirl.factories.map(&:name).each do |factory_name|
    describe factory_name.to_s.classify do
      it 'should be valid' do
        expect(build(factory_name)).to be_valid
        expect { create(factory_name) }.not_to raise_error
      end
    end
  end
end
