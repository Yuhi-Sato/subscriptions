class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :service_name
      t.string :category
      t.string :official_url

      t.timestamps
    end
  end
end
