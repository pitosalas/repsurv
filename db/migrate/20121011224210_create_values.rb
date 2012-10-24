class CreateValues < ActiveRecord::Migration
    def change
      create_table :values do |t|
        t.string   "value"
        t.integer  "round_id"
        t.integer  "participant_id"
        t.integer  "question_id"
        t.integer  "program_id"
        t.datetime "created_at",    :null => false
        t.datetime "updated_at",    :null => false
      end
    end
end
