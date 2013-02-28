class ProgramServices
  def initialize program
    @prog = program
    @result_code = nil
  end

  def smart_add_participant  u_name, u_email, u_password
    usr = find_or_add_user(u_name, u_email, u_password)
    add_participant(usr)
    @result_code
  end

  private

  def find_or_add_user name, email, password
    user = User.where(email: email)
    if (user.size == 0)
      user = User.create(name: name, email: email, password: password)
      if user.errors.empty?
        @result_code = :added_usr_n_part
      else
        @result_code = :invalid_usr
      end
    else
      user = user[0]
      @result_code = :added_participant
    end
    user
  end

  def add_participant user
    part = @prog.participants.build(user: user, hidden: false)
    part.save
  end
end