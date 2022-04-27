class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.references :survivor, null: false, foreign_key: true
      t.belongs_to :by_survivor, null: true, index: true
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
