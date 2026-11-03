class AddSlugToTurmas < ActiveRecord::Migration[8.0]
  def change
    add_column :turmas, :slug, :string
  end
end
