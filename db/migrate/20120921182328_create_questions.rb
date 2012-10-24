class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string   "text"
      t.integer  "pos"
      t.integer  "program_id"
      t.text     "active"
      t.text     "data_type"
      t.timestamps
    end
  end
end
