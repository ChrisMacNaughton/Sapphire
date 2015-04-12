require 'spec_helper'

RSpec.describe "ast nodes" do
  it "should to_s Int" do
    expect(5.int.to_s).to eq('5')
  end

  it "should to_s Float" do
    expect(5.0.float.to_s).to eq('5.0')
  end

  it "should to_s True" do
    expect(true.bool.to_s).to eq('true')
  end

  it "should to_s False" do
    expect(false.bool.to_s).to eq('false')
  end

  [
    "+",
    "-",
    "*",
    "/",
    "<",
    "<=",
    "==",
    ">",
    ">=",
  ].each do |op|
    it "should to_s Call #{op}" do
      expect(Call.new(5.int, op.to_sym, [6.int]).to_s).to eq("5 #{op} 6")
    end
  end

  it "should to_s Def with no args" do
    expect(Def.new("foo", [], [1.int]).to_s).to eq("def foo\n  1\nend")
  end

  it "should to_s Def with args" do
    expect(Def.new("foo", ['var'.var], [1.int]).to_s).to eq("def foo(var)\n  1\nend")
  end

  it "should to_s Def with many expressions" do
    expect(Def.new("foo", [], [1.int, 2.int]).to_s).to eq("def foo\n  1\n  2\nend")
  end

  it "should to_s Var" do
    expect("foo".var.to_s).to eq("foo")
  end

  it "should to_s Call with no args" do
    expect(Call.new(nil, "foo").to_s).to eq("foo()")
  end

  it "should to_s Call with args" do
    expect(Call.new(nil, "foo", [1.int, 2.int]).to_s).to eq("foo(1, 2)")
  end

  it "should to_s Call with no block" do
    expect(Call.new(nil, "foo", [], Block.new).to_s).to eq("foo() do\nend")
  end

  it "should to_s If" do
    expect(If.new("foo".var, 1.int).to_s).to eq("if foo\n  1\nend")
  end

  it "should to_s Not" do
    expect(Call.new("foo".var, :'!@').to_s).to eq("!foo")
  end

  ['return', 'break', 'next', 'yield'].each do |keyword|
    it "should to_s #{keyword.capitalize}" do
      expect(eval(keyword.capitalize).new(["foo".var, 1.int]).to_s).to eq("#{keyword} foo, 1")
    end
  end
end