class ParserRegister
  @@types = {} of String => Parser.class

  def self.register(type, klass)
    @@types[type] = klass
  end

  def self.types
    @@types
  end
end
