class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.integer :progress
      t.references :parent_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
