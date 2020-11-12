class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :date, null: false
      t.belongs_to :state, type: :string, foreign_key: { primary_key: 'code' }
      t.integer :deaths
      t.integer :hospitalized
      t.integer :positive

      t.timestamps
    end
    add_index :reports, [:state_id, :date], unique: true
  end
end
