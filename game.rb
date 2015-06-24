class Game

  attr_accessor :tribes

  def initialize(*tribes)
    @tribes = tribes || []
    puts
    puts "Welcome to Survivor!"
  end

  def add_tribe(tribe)
    @tribes << tribe
  end

  def immunity_challenge
    losing_tribe = @tribes.sample
    puts
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
    new_tribe = Tribe.new(name: tribe_name, members: remaining_castaways)

    # Deleting all the existing tribes...
    @tribes = []

    # ...to make room for our new merged tribe.
    add_tribe(new_tribe)

    # Return the new merged tribe
    new_tribe
  end

  def individual_immunity_challenge
    winner = tribes.first.members.sample
    puts "\n#{winner} won the individual immunity challenge and is safe from elimination."
    winner
  end

end