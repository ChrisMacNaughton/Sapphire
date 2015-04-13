require_relative 'visitor'

require 'llvm/core'
require 'llvm/execution_engine'
require 'llvm/transforms/scalar'

LLVM::Target.init('X86')

module Sapphire
  def run(code)
    node = parse code
    type node

    visitor = CodeGenVisitor.new(node.type)
    node.accept visitor

    visitor.mod.verify

    visitor.mod.dump if ENV['DUMP']

    engine = LLVM::JITCompiler.new(visitor.mod)
    engine.run_function visitor.main
  end

  class CodeGenVisitor < Visitor
    attr_reader :mod, :main

    def initialize(return_type)
      @mod = LLVM::Module.new("Sapphire")
      @main = @mod.functions.add("sapphire_main", [], return_type.llvm_type)
      @entry = @main.basic_blocks.append("entry")
      @builder = LLVM::Builder.new
      @builder.position_at_end(@entry)
      @vars = {}
    end

    def end_visit_expressions(node)
      @builder.ret @last
    end

    def visit_bool(node)
      @last = LLVM::Int1.from_i(node.value ? 1 : 0)
    end

    def visit_int(node)
      @last = LLVM::Int(node.value)
    end

    def visit_float(node)
      @last = LLVM::Float(node.value)
    end

    def visit_assign(node)
      node.value.accept self

      var = @vars[node.target.name]
      unless var && var[:type] == node.type
        var = @vars[node.target.name] = {
          ptr: @builder.alloca(node.type.llvm_type, node.target.name),
          type: node.type
        }
      end
      @builder.store @last, var[:ptr]

      false
    end

    def visit_var(node)
      var = @vars[node.name]
      @last = @builder.load var[:ptr], node.name
    end
  end

end