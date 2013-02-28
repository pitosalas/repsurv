require_relative '../../lib/support/participant_importer'
require 'rspec'

describe ParticipantImporter do
  let (:simple_text) {"pitosalas@gmail.com\njohn_smith@abc.com"}
  let (:invalid_text) {"pitosalas@gmail.com\njohn_smith@abccom"}
  let (:complex_text) { <<END
    pitosalas@gmail.com,Pito Salas
    john_smith@abc.com, John Smith
    jane@aol.com, Jane Frank
    chris@microsoft.com.com, Chris Salas
END
    }
  let(:pserv) {
    pserv = mock("ProgramServices")
  }
  let (:pi) {ParticipantImporter.new(pserv)}

  describe "construction" do
    it "contructs safely" do
      pi.n_users.should == 0
    end
  end

  describe "text import" do
    it "parses simple text correctly" do
      pi.import_info = simple_text
      pi.parse_import_info
      pi.n_users.should == 2
    end
    it "parses more complicated text correctly" do
      pi.import_info = complex_text
      pi.parse_import_info
      pi.n_users.should == 4
    end

    it "fails on an invalid email" do
      pi.import_info = invalid_text
      pi.parse_import_info.should
      pi.importable_users.reduce(0) { |memo, usr| memo + (usr[3] ? 1 : 0) }.should == 1
    end
  end

  describe "adding participants" do
    it "properly adds participants" do
      pserv = double("ProgramServices")
      pserv.should_receive(:smart_add_participant).with(nil, "pitosalas@gmail.com", nil).and_return(:added_usr_n_part)
      pserv.should_receive(:smart_add_participant).with(nil, "john_smith@abc.com", nil).and_return(:added_usr_n_part)
      pi = ParticipantImporter.new(pserv)
      pi.import_info = simple_text
      pi.perform_import
    end

    it "does not add invalid email participant" do
      pserv = double("ProgramServices")
      pserv.should_receive(:smart_add_participant).with(any_args()).exactly(1).times.and_return(:invalid_email)
      pi = ParticipantImporter.new(pserv)
      pi.import_info = invalid_text
      result = pi.perform_import
     end
  end
  describe "logging results" do
    it "properly logs invalid email" do 
      pserv = double("ProgramServices")
      pi = ParticipantImporter.new(pserv)
      pi.import_info = "pitosalas@gmail"
      pi.perform_import
      pi.message_log[0].include?("invalid").should be_true
    end
    it "properly logs added a participant" do
      pserv = double("ProgramServices")
      pserv.should_receive(:smart_add_participant).with(any_args()).and_return(:added_participant)
      pi = ParticipantImporter.new(pserv)
      pi.import_info = "pitosalas@gmail.com"
      pi.perform_import
      pi.message_log[0].include?("added as participant").should be_true
    end
  end
end
