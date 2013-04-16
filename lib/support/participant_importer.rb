require 'csv'
class ParticipantImporter
  attr_accessor :import_info, :message_log
  attr_reader :importable_users


  def initialize prog_service
    @prog_srv = prog_service
    @importable_users = []
    @message_log = []
    @options = Hash.new
    @messages = 
      {  invalid_email: " - invalid email",
         existing_user: " - already existed, adding as a participant", 
         duplicate_user: " - email already in use, not adding",
         added_participant: " - added as participant",
         added_usr_n_part: " - created new user and added as participant",
         invalid_usr: " - invalid user details"
      }
  end


  def perform_import
    parse_import_info
    build_users_and_participants
  end

  def build_users_and_participants
    @importable_users.each do |user_info|
      result_code = :invalid_email
      if user_info[3]
        result_code = @prog_srv.smart_add_participant(user_info[1], user_info[0], user_info[2])
      end
      @message_log << user_info[0] + @messages[result_code]
    end
  end

  def parse_import_info
    import_info_array = CSV.parse(@import_info, @options)
    clean_and_check_import_info( import_info_array)
  end

  def clean_and_check_import_info import_info_array
    @importable_users = import_info_array.map { |u_i| [u_i[0].strip, u_i[1], u_i[2], valid_email?(u_i[0]) ] }
  end

  def valid_email? email
    email_regex =  /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
    email_regex.match(email).nil? ? false : true
  end

  def n_users
    @importable_users.size
  end
end

