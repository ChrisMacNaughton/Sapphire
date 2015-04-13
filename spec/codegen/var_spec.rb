require 'spec_helper'

RSpec.describe 'Code Gen: var' do
  it 'codegens var' do
    expect(run('a = 1; 1.5; a').to_i).to eq(1)
  end

  it 'codegens var with same name and different type' do
    expect(run('a = 1; a = 2.5; a').to_f).to eq(2.5)
  end
end