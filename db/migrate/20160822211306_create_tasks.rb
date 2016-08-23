class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :deadline
      t.boolean :complete
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
