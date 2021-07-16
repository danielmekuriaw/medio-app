class CreateJourneys < ActiveRecord::Migration[5.1]
  def change
    create_table :journeys do |t|
      t.string :point1
      t.string :point2
      
      t.timestamps
    end
  end
end
