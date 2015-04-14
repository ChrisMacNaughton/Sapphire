module Sapphire
  class Token
    attr_accessor :type, :value, :line_number, :column_number

    def location
      [line_number, column_number]
    end

    def to_s
      value || type
    end
  end
end