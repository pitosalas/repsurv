u = User.new(name: "Pito Salas", email: "pitosalas@gmail.com", password: "daniel")
u.roles = [:admin]
u.save
