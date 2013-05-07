class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer   "program_id"
      t.integer   "number"
      t.integer   "start"
      t.integer   "fin"
      t.text      "status"
      t.boolean   "open"
      t.datetime  "open_date"
      t.datetime  "close_date"
      t.timestamps
    end
  end
end
