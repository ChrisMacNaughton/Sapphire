require 'spec_helper'

RSpec.describe 'Code Gen: def' do
  it 'codegens call without args' do
    expect(run('def foo; 1; end; 2; foo').to_i).to eq(1)
  end

end