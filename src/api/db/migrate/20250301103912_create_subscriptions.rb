class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.date :next_payment_date
      t.string :memo

      t.timestamps
    end
  end
end
