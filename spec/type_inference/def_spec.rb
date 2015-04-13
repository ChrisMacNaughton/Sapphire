require 'spec_helper'

RSpec.describe 'Type Inference: def' do
  it 'types a call with an int' do
    input =  parse 'def foo; 1; end; foo'
    type input
    expect(input.last.type).to eq(Type::Int)
  end

  it 'types a call with a float' do
    input =  parse 'def foo; 2.3; end; foo'
    type input
    expect(input.last.type).to eq(Type::Float)
  end

  it 'types a call with a bool' do
    input =  parse 'def foo; true; end; foo'
    type input
    expect(input.last.type).to eq(Type::Bool)
  end

  it 'types a call with an argument' do
    input = parse 'def foo(x); x; end; foo 1; foo 2.3'
    type input
    expect(input[1].type).to eq(Type::Int)
    expect(input[2].type).to eq(Type::Float)
  end

  it 'types a call with an argument and uses a new scope' do
    input = parse 'x = 2.3; def foo(x); x; end; foo 1; x'
    type input
    expect(input.last.type).to eq(Type::Float)
  end
end