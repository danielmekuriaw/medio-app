class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.datetime :birth_date

      t.references :user, foreign_key: { to_table: :users }, default: nil

      t.timestamps
    end
  end
end
