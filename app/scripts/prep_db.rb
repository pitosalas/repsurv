require_relative "./metricalc/metricalc.rb"

class PrepDb
  def self.run 
    @sample = SampleData.new
    @sample.program_init
    @sample.questions_init
    @sample.rounds_init
    @sample.users_init
    @sample.data_init
  end
end

class SampleData
  attr_reader :surv
  def to_s
    "SampleData!"
  end

  def initialize
    @surv = SurveyData.new
    inp = InputData.new
    inp.read "app/scripts/metricalc/data/week9file.csv", @surv
    @surv.process
    @round_range = []
  end

  def program_init
    @prog = Program.create(name: "JBS 2012", 
                   description: "Summer of 2012",
                   open: false,
                   locked: true)
    puts "1 Program created 'JBS 2012'"
  end

  def questions_init
    @surv.n_questions.times do |x|
      puts "Adding question #{@surv.question(x-1).text} [#{@surv.question(x-1).index}]"
      @prog.questions.create(text: @surv.question(x-1).text, pos: @surv.question(x-1).index)
    end
  end

  def rounds_init
    rcount = 0
    @surv.rounds.each do |rnd|
      puts "Adding round #{rcount}, start: #{rnd.start}, fin: #{rnd.fin}"
      @prog.rounds.create(number: rcount, start: rnd.start, fin: rnd.fin, open: false)
      rcount += 1
    end
    last_round = Round.last
    last_round.open = true
    last_round.save!
  end

  def users_init
    users = ["Rachel", "Jeremy Coffman", "Sam", "Eitan", "Kendall", "Avishek Neupane", 
             "Mustapha Isa", "Shu Lin", "Fatima", "Ezra", "Tom"]
    make_user(true, "unknown", "unknown@gmail.com")
    users.each { |u| make_user(true, u, "#{u}@gmail.com") }
    puts "Added Unknown + 11 Students from JBS 2012"
  end

  def make_user hidden, name, email
    en_pw = "$2a$10$eyUeqMwEMCdB63yX.jRLke6D9JPmaGHzWghuJu4Mi/k0ABhaunfMy"
    User.new do |u| 
      u.email = email
      u.name = name
      u.password = "daniel"
      u.save!
      p = @prog.participants.create(hidden: hidden)
      p.user = u
      p.save!
    end
  end

  def data_init
    puts "[Adding Rounds info]"
    Round.all.each do |rnd|
      puts "Adding data items for Round #{rnd.number}"
      Question.all.each do |qst|
        ((rnd.start)..(rnd.fin)).each do 
          |resp_row|
          Value.create do |v|
            v.program = @prog
            cell = @surv.cell(qst.pos, resp_row)
            who = @surv.cell(30, resp_row)
            u = User.where("name LIKE ?", who).first
            u = User.where(name: "unknown").first if u.nil?
            v.participant = Participant.where(user_id: u.id).first
            v.value = !cell.nil? ? (Response.string2choice(cell)) : nil
            v.question = qst
            v.round = rnd
          end
        end
      end
    end
  end
end

