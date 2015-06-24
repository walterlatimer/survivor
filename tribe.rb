class Tribe
  attr_accessor :members
  attr_reader :name

  COLORS = %w(red green yellow blue light_blue)
  @@used_colors = []

  def initialize(options = {})
    @name = options[:name] || "Unnamed Tribe"
    @members = options[:members] || []
    @color = assign_color
    puts "Tribe " + @name.send(@color) + " was created with members: #{@members.join(", ")}"
  end

  def inspect
    [@name, @members]
  end

  def to_s
    @name.send(@color)
  end

  def tribal_council(options = {})
    voted_off = @members.reject{|x| x == options[:immune]}.sample
    puts "#{voted_off} was voted off the island."

    @members.delete(voted_off)

    puts "Remaining tribemates on " + @name.send(@color) + " are: #{@members.join(", ")}"

    voted_off
  end

  private

  def assign_color
    color = COLORS.reject{ |x| @@used_colors.include? x }.sample
    @@used_colors << color
    color
  end

end