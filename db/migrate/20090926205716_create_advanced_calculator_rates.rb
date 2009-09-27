class CreateAdvancedCalculatorRates < ActiveRecord::Migration
  def self.up
    create_table :bucket_rates do |t|
      t.references :calculator
      t.decimal :floor, :precision => 8, :scale => 2
      t.decimal :ceiling, :precision => 8, :scale => 2
      t.decimal :rate, :precision => 8, :scale => 2
      t.timestamps
    end

    add_column :calculators, :advanced, :boolean, :default => false
  end

  def self.down
    drop_table :bucket_rates
    remove_column :calculators, :advanced
  end
end
