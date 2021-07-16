class CreateJourneys < ActiveRecord::Migration[5.1]
  def change
    create_table :journeys do |t|
      t.string :point1
      t.string :point2
      t.string :mode
      t.string :radius, default: 5000
      t.string :preference
      
      t.timestamps
    end
  end
end
