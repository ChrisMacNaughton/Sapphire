require 'spec_helper'

RSpec.describe 'Code Gen: var' do
  it 'codegens var' do
    expect(run('a = 1; 1.5; a').to_i).to eq(1)
  end
end