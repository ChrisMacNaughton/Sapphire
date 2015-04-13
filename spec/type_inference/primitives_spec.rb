require 'spec_helper'

RSpec.describe 'Type inference: primitives' do
  it 'types a bool' do
    input = false.bool
    type input
    expect(input.type).to eq(Type::Bool)
  end

  it 'types an int' do
    input = 1.int
    type input
    expect(input.type).to eq(Type::Int)
  end

  it 'types a float' do
    input = 2.3.float
    type input
    expect(input.type).to eq(Type::Float)
  end
end