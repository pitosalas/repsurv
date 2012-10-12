class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer  "program_id"
      t.integer  "number"
      t.integer  "start"
      t.integer  "fin"
      t.text     "status"
      t.timestamps
    end
  end
end
