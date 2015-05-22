require File.join(File.dirname(__FILE__), "parser_base")

# Simple Recursive-Descent s-expression parser
class SEXParser < ParserBase
  include Tokens

  def initialize s
    @s = s # The scanner
  end

  def parse
    return nil unless @s.expect("%s")
    return parse_sexp || raise("Expected s-expression")
  end

  def parse_sexp
    return nil unless @s.expect("(")
    @s.ws
    exprs = zero_or_more(:exp)
    raise "Expected ')'" unless @s.expect(")")
    return exprs
  end

  def parse_exp
    @s.ws
    (ret = @s.expect(Atom) || @s.expect(Int) || @s.expect(Quoted) || parse_sexp) && @s.ws
    return ret
  end
end