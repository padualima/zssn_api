class CreateSurvivors < ActiveRecord::Migration[7.0]
  def change
    create_table :survivors do |t|
      t.string :name, null: false, default: ''
      t.integer :gender, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
