class Game

  attr_accessor :tribes

  def initialize
    @tribes = []
    puts "Welcome to Survivor!"
  end

  def add_tribe(tribe)
    @tribes << tribe
    puts "We have a tribe named #{tribe.name} with members: #{tribe.members.join(", ")}"
  end

  def immunity_challenge
    losing_tribe = @tribes.sample
    puts "Immunity challenge loser is #{losing_tribe}."
    puts "#{losing_tribe} must go to Tribal Council."
    losing_tribe
  end

  def merge(tribe_name)
    puts "Drop your buffs, it's time for the merge!"

    # Create remaining castaways array out of all the existing tribes' members
    remaining_castaways = @tribes.collect { |tribe| tribe.members }
    remaining_castaways.flatten!

    # Create our new merged tribe with the remaining castaways
    new_tribe = Tribe.new(tribe_name)
    new_tribe.members = remaining_castaways

    # Deleting all the existing tribes...
    @tribes = []

    # ...to make room for our new merged tribe.
    add_tribe(new_tribe)

    # Return the new merged tribe
    new_tribe
  end

  def individual_immunity_challenge
    winner = tribes.first.members.sample
    puts "#{winner} won the individual immunity challenge and is safe from elimination."
    winner
  end

end

class Tribe
  attr_accessor :name, :members

  def inspect
    @members
  end

  def to_s
    @name
  end

  def initialize(name)
    @name = name
    @members = []
  end

  def go_to_tribal_council(options = {})
    voted_off = @members.reject{|x| x == options[:immune]}.sample
    puts "#{voted_off} was voted off the island."
    @members.delete(voted_off)
    puts "Remaining tribemates are: #{@members.join(", ")}"
  end

end

class Castaway
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


def test

  # Create a new game of Survivor
  survivor = Game.new

  # Create two new tribes with names
  tribe1 = Tribe.new("Ukelele")
  tribe2 = Tribe.new("Austonbunsen")

  # Create an array of twenty hopefuls to compete on the island of Wynco-Wynco
  castaways = %w(walter ed gabe diego juliana johanna juha sofia ben lenora weston dena zach jon seanh seans david ari anthony jonsnow)
  castaways.map! do |castaway|
    Castaway.new(castaway)
  end
  castaways.shuffle!

  # Adding the castaways to the tribes we created
  tribe1.members = castaways.shift(10)
  tribe2.members = castaways.shift(10)

  # Add the new tribes to our game
  survivor.add_tribe(tribe1)
  survivor.add_tribe(tribe2)

  # Host an immunity challenge and eliminate a contestant from the losing tribe eight times
  8.times do
    losing_tribe = survivor.immunity_challenge
    losing_tribe.go_to_tribal_council
  end

  # After 8 eliminations, merge the two tribes together
  merge_tribe = survivor.merge("Cello")

  9.times do
    immunity_winner = survivor.individual_immunity_challenge
    merge_tribe.go_to_tribal_council(immune: immunity_winner)
  end

end

test