class SampleData
  def self.create
    require_relative "./metricalc/metricalc.rb"
    surv = SurveyData.new
    inp = InputData.new
    inp.read "app/scripts/metricalc/data/week9file.csv", surv
    surv.process
    round_range = []

    if true
      Program.create(name: "JBS 2012", 
                     description: "Summer of 2012",
                     open: false,
                     locked: true)
      puts "1 Program created 'JBS 2012'"
    end

    if true
      prog = Program.first
      surv.n_questions.times do |x|
        puts "Adding question #{surv.question(x-1).text} [#{surv.question(x-1).index}]"
        prog.questions.create(text: surv.question(x-1).text, pos: surv.question(x-1).index)
      end
    end

    if true
      prog = Program.first
      rcount = 0
      surv.rounds.each do |rnd|
        puts "Adding round #{rcount}, start: #{rnd.start}, fin: #{rnd.fin}"
        prog.rounds.create(number: rcount, start: rnd.start, fin: rnd.fin, open: false)
        rcount += 1
      end
      last_round = Round.find(9)
      last_round.open = true
      last_round.save!
    end

    if true
      prog = Program.first

      prog.participants.create(name: "Unknown", hidden: true)
      prog.participants.create(name: "Rachel", hidden: false)
      prog.participants.create(name: "Jeremy Coffman", hidden: false)
      prog.participants.create(name: "Sam", hidden: false)
      prog.participants.create(name: "Eitan", hidden: false)
      prog.participants.create(name: "Kendall", hidden: false)
      prog.participants.create(name: "Avishek Neupane", hidden: false)
      prog.participants.create(name: "Mustapha Isa", hidden: false)
      prog.participants.create(name: "Shu Lin", hidden: false)
      prog.participants.create(name: "Fatima", hidden: false)
      prog.participants.create(name: "Ezra", hidden: false)
      prog.participants.create(name: "Tom", hidden: false)
      puts "Added Unknown + 11 Students from JBS 2012"
    end

    if true
      puts "[Adding Rounds info]"
      prog = Program.first
      Round.all.each do |rnd|
        puts "Adding data items for Round #{rnd.number}"
        Question.all.each do |qst|
#          puts "[hanling question #{qst.text}]"
          ((rnd.start)..(rnd.fin)).each do 
            |resp_row|
            Value.create do |v|
              v.program = prog
              cell = surv.cell(qst.pos, resp_row)
              who = surv.cell(30, resp_row)
              if (resp = Participant.find(:first, :conditions => ["name LIKE ?", who]))
                v.participant = resp
              else
                v.participant = Participant.find_by_name("Unknown")
              end
              v.value = !cell.nil? ? (Response.string2choice(cell)) : nil
              v.question = qst
              v.round = rnd
            end
          end
        end
      end
    end
  end
end

