class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |d|
      d.string :doctor_name
      d.string :zipcode
      d.string :specialty
      d.integer :rating
    end
  end
end
