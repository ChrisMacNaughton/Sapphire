class Arg

  attr_reader :name, :rest

  alias_method :rest?, :rest
  def initialize name, *modifiers
    @name = name
    modifiers.each do |m|
      @rest = true if m == :rest
    end
  end

  def type
    rest ? :argaddr : :arg
  end


end