 u1 = User.create!(email: "c#{rand(10000)}@x.com", password: "asdadasdasds")
 u2 = User.create!(email: "c#{rand(10000)}@x.com", password: "asdadasdasds")
 u3 = User.create!(email: "c#{rand(10000)}@x.com", password: "asdadasdasds")
 
 p1 = Program.create!(name: "Program 1")
 p2 = Program.create!(name: "Program 2")
 
 p1.moderator = u1; p1.save
 p2.moderator = u2; p2.save
 
 part1 = Participant.create!; part1.user = u1; part1.program = p1 ; part1.save
 part2 = Participant.create!; part2.user = u2; part2.program = p1 ; part2.save
 part3 = Participant.create!; part3.user = u3; part3.program = p1 ; part3.save
 