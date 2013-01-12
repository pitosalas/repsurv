class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :moderator_id     # user_id of moderator of this program
      t.string :description
      t.boolean :open
      t.boolean :locked
      t.boolean :suppress_hidden_participants, default: false
      t.timestamps
    end
  end
end
