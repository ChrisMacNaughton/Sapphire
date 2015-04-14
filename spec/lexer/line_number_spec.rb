require 'spec_helper'

RSpec.describe 'Lexer: line number' do
  it 'stores line numbers' do
    lexer = Lexer.new "1\n2"
    token = lexer.next_token
    expect(token.type).to eq(:INT)
    expect(token.line_number).to eq(1)

    token = lexer.next_token
    expect(token.type).to eq(:NEWLINE)
    expect(token.line_number).to eq(1)

    token = lexer.next_token
    expect(token.type).to eq(:INT)
    expect(token.line_number).to eq(2)
  end
end