class CreateTodosTable < ActiveRecord::Migration
  def change
    create_table :todos do |a|
      a.string :title
      a.boolean :done
    end
  end
end
