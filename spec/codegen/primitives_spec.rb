require 'spec_helper'

RSpec.describe 'Code Gen: primitives' do
  it 'codegens int' do
    expect(run('1').to_i).to eq(1)
  end

  it 'codegems float' do
    expect(run('1; 2.5').to_f).to eq(2.5)
  end
end