class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.integer :program_id
      t.boolean :hidden
      t.timestamps
    end
  end
end
