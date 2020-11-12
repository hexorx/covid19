class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states, id: false do |t|
      t.string :code, null: false
      t.string :name
      t.string :notes
      t.string :site
      t.string :twitter

      t.timestamps
    end
    add_index :states, :code, unique: true
  end
end
