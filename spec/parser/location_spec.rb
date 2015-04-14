require 'spec_helper'

RSpec.describe 'Parser: location' do
  context 'line numbers' do
    it 'stores line numbers' do
      nodes = parse "1 + 2\n3 + 3"
      expect(nodes[0].line_number).to eq(1)
      expect(nodes[0].obj.line_number).to eq(1)
      expect(nodes[0].args[0].line_number).to eq(1)
      expect(nodes[1].line_number).to eq(2)

    end

    it 'stores column numbers' do
      nodes = parse "1 + 2\n  call  arg1,  arg2"
      expect(nodes[0].column_number).to eq(1)
      expect(nodes[0].name_column_number).to eq(3)
      expect(nodes[0].obj.column_number).to eq(1)
      expect(nodes[0].args[0].column_number).to eq(5)
      expect(nodes[1].column_number).to eq(3)
      expect(nodes[1].name_column_number).to eq(3)
      expect(nodes[1].args[0].column_number).to eq(9)
      expect(nodes[1].args[1].column_number).to eq(16)
    end
  end
end