class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.integer :program_id
      t.boolean :visible
      t.string :datatype
      t.string :blurb

      t.timestamps
    end
  end
end
