class CreatePlans < ActiveRecord::Migration[7.2]
  def change
    create_table :plans do |t|
      t.references :service, null: false, foreign_key: true
      t.string :plan_name
      t.decimal :price
      t.string :currency
      t.string :billing_cycle

      t.timestamps
    end
  end
end
