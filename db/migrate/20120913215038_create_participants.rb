class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :program_id
      t.integer :user_id
      t.string :guid
      t.boolean :hidden 
      t.timestamps
    end
  end
end
