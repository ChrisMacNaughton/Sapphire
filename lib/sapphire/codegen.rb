require_relative 'visitor'

require 'llvm/core'
require 'llvm/execution_engine'
require 'llvm/transforms/scalar'

LLVM::Target.init('X86')

module Sapphire
  def run(code)
    node = parse code
    type node

    visitor = CodeGenVisitor.new
    node.accept visitor

    engine = LLVM::JITCompiler.new(visitor.mod)
    engine.run_function visitor.main
  end

  class CodeGenVisitor < Visitor
    attr_reader :mod, :main

    def initialize
      @mod = LLVM::Module.new("Sapphire")
      @main = @mod.functions.add("main", [], LLVM::Int)
      @entry = @main.basic_blocks.append("entry")
      @builder = LLVM::Builder.new
      @builder.position_at_end(@entry)
    end

    def end_visit_expressions(node)
      @builder.ret @last
    end

    def visit_int(node)
      @last = LLVM::Int(node.value.to_i)
    end
  end

end