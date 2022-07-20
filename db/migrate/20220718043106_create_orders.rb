class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :total_amount
      t.decimal :tax
      t.decimal :total_to_pay
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
