class CreateValues < ActiveRecord::Migration
    def change
      create_table :values do |t|
        t.string   "value"
        t.integer  "round_id"
        t.integer  "respondent_id"
        t.datetime "created_at",    :null => false
        t.datetime "updated_at",    :null => false
        t.integer  "question_id"
      end
    end
end
