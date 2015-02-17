require 'rails_helper'

describe FactoryGirl do
  FactoryGirl.factories.map(&:name).each do |factory_name|
    describe factory_name.to_s do
      it 'should create record' do
        2.times { expect(create(factory_name)).to be_persisted }
      end
    end
  end
end
