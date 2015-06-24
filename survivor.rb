require "./game.rb"
require "./tribe.rb"
require "./contestant.rb"
require "./jury.rb"
require "./colorize.rb"

# Create an array of twenty hopefuls to compete on the island of Borneo
contestants = %w(walter ed gabe diego juliana johanna juha sofia ben lenora weston dena zach jon seanh seans david ari anthony adriana)
contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!

# Create two new tribes with names
coyopa = Tribe.new(name: "Pagong", members: contestants.shift(10))
hunapu = Tribe.new(name: "Tagi", members: contestants.shift(10))

# Create a new game of Survivor
borneo = Game.new(coyopa, hunapu)

# Host an immunity challenge and eliminate a contestant from the losing tribe eight times
8.times do
  losing_tribe = borneo.immunity_challenge
  losing_tribe.tribal_council
end

# After 8 eliminations, merge the two tribes together
merge_tribe = borneo.merge("Cello")


3.times do
  immunity_winner = borneo.individual_immunity_challenge
  merge_tribe.tribal_council(immune: immunity_winner)
end

jury = Jury.new

7.times do
  immunity_winner = borneo.individual_immunity_challenge
  juror = merge_tribe.tribal_council(immune: immunity_winner)
  jury.add_member(juror)
end

finalists = merge_tribe.members

winner = jury.vote(finalists)