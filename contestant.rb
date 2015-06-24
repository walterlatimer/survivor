class Contestant
  attr_accessor :name

  def inspect
    @name
  end

  def to_s
    @name
  end

  def initialize(name)
    @name = name
  end

end