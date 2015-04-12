module Crystal
  class Exception < StandardError
    def message(source = nil)
      to_s(source)
    end
  end
end