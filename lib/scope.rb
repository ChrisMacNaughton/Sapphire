class Scope
  def initialize compiler,func
    @c = compiler
    @func = func
  end

  def rest?
    @func ? @func.rest? : false
  end

  def get_arg a
    a = a.to_sym
    if @func
      arg = @func.get_arg(a)
      return arg if arg
    end
    return [:addr,a]
  end
end