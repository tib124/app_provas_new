class CreateTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :turmas do |t|
      t.string :nome, null: false
      t.references :usuario, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
