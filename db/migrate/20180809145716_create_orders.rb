class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :description
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
