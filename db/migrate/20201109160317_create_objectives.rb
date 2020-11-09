class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.string :name
      t.string :idea
      t.string :content
      
      t.integer :user_id
    end
  end
end
