class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :details
      t.string :city
      t.string :period
      t.string :timings
      t.string :telephone

      t.timestamps
    end
  end
end
