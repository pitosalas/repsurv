class ProgramServices
  def initialize program
    @prog = program
    @result_code = nil
  end

  def smart_add_participant  u_name, u_email, u_password
    usr = find_or_add_user(u_name, u_email, u_password)
    add_participant(usr)
    puts "sap: #{@result_code}"
    @result_code
  end

  private

  def find_or_add_user name, email, password
    puts "#foau"
    user = User.where(email: email)
    if (user.size == 0)
      user = User.create(name: name, email: email, password: password)
      @result_code = :added_usr_n_part
    else
      user = user[0]
      @result_code = :added_participant
    end
    puts "foau: #{@result_code}"
    user
  end

  def add_participant user
    @prog.participants.build(user: user, hidden: false)
  end
end