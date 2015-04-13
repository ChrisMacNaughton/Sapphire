require 'spec_helper'

RSpec.describe 'Type inference: var' do
  it 'types an assign' do
    input = Assign.new('a'.var, 1.int)
    type input
    expect(input.target.type).to eq(Type::Int)
    expect(input.value.type).to eq(Type::Int)
    expect(input.type).to eq(Type::Int)
  end

  it 'types a variable' do
    input = parse 'a = 1; a'
    type input

    expect(input.last.type).to eq(Type::Int)
    expect(input.type).to eq(Type::Int)
  end

  it 'types a variable that gets a new type' do
    input = parse 'a = 1; a; a = 2.3; a'
    type input
    expect(input[1].type).to eq(Type::Int)
    expect(input[2].type).to eq(Type::Float)
    expect(input[3].type).to eq(Type::Float)
  end

end