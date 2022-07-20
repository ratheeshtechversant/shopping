class CreateProductPacks < ActiveRecord::Migration[7.0]
  def change
    create_table :product_packs do |t|
      t.integer :pack_weight
      t.string :weight_type
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
