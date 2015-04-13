require 'spec_helper'

RSpec.describe 'Code Gen: primitives' do
  it 'codegens int' do
    expect(run('1').to_i).to eq(1)
  end
end