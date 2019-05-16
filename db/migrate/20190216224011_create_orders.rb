class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :number, unique: true
      t.integer :status
      t.references :user, foreign_key: true
      t.references :delivery, foreign_key: true
      t.references :credit_card, foreign_key: true

      t.timestamps
    end
  end
end
