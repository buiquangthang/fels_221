class ChangeColumnLearnInSearch < ActiveRecord::Migration[5.0]
  def change
    remove_column :searches, :learn, :boolean
    add_column :searches, :learn, :integer
  end
end
