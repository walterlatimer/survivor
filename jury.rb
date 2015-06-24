class Jury

  attr_accessor :members

  def initialize
    @members = []
    puts "\nThe Jury Phase Begins!".light_grey
  end

  def add_member(juror)
    @members << juror
    puts "#{juror} is member #{@members.size} of the jury.".light_grey
  end

  def vote(finalists)

    puts
    votes = Hash.new(0)

    @members.each do |member|
      vote = finalists.sample
      votes[vote] += 1
      puts "#{member} cast their vote for #{vote}.".light_grey
    end

    finalists.each do |finalist|
      puts "#{finalist} received #{votes[finalist]} votes.".light_grey
    end

    winner = votes.max_by{|k,v| v}[0]
    puts
    puts "The winner is #{winner}!".light_grey
  end

end