require 'spec_helper'

RSpec.describe 'Lexer: location' do
  context 'line numbers' do
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

  context 'column numbers' do
    let(:lexer) { Lexer.new "1;  ident; def;\n4"}

    it 'stores column numbers' do
      assert_token :INT, 1
      assert_token :';', 2
      assert_token :SPACE, 3
      assert_token :IDENT, 5
      assert_token :';', 10
      assert_token :SPACE, 11
      assert_token :IDENT, 12
      assert_token :';', 15
      assert_token :NEWLINE, 16
      assert_token :INT, 1
    end

    def assert_token(type, column_number)
      token = lexer.next_token
      expect(token.type).to eq(type)
      expect(token.column_number).to eq(column_number)
    end
  end
end