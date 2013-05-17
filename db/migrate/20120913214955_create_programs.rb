class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :moderator_id     # user_id of moderator of this program
      t.string :description
      t.datetime :opened
      t.datetime :closed
      t.boolean :open, default: true
      t.boolean :locked, default: false
      t.boolean :suppress_hidden_participants, default: false
      t.timestamps
    end
  end
end
