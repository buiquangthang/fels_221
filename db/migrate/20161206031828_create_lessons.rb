class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :category, foreign_key: true
      t.integer :score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
