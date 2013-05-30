require 'spec_helper'

describe Spree::Admin::RelationsController do
  it 'should respond to model_class as Spree::Relation' do
    controller.send(:model_class).should eql(Spree::Relation)
  end
end
