class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :card_type
      t.integer :cost
      t.text :description
      t.text :flavor
      t.integer :attack
      t.integer :health
      t.integer :deck_id

      t.timestamps null: false
    end
  end
end
