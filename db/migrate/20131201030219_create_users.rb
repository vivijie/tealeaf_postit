class Createposts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :username
    end
  end
end
