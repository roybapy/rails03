class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.text :start
      t.integer :price

      t.timestamps
    end
  end


  def header
    create_table :header do |t|
      t.text :city
      t.text :banner
      t.text :slogan
    end
  end

  def cityimg
    create_table :cityimg do |t|
      t.text :city
      t.text :thumb
      t.text :banner
    end
  end

def topdeals
  create_table :topdeals do |t|
    t.text :name
    t.text :start
    t.text :stop
    t.text :date
    t.int :price
    t.int :avgp
    t.int :perl
    t.text :imgl
    t.int :live
  end
end

def alldeals
  create_table :alldeals do |t|
    t.text :name
    t.text :start
    t.text :stop
    t.text :date
    t.int :price
    t.int :avgp
    t.int :perl
    t.text :imgl
    t.int :live
  end
end

def scan_result
   create_table :scan_result do |t|
     t.column :fname, 'text'
     t.column :perl, 'int'
     t.column :tripl, 'int'
     t.column :status, 'text'
     t.column :stime, 'timestamp with time zone'
   end
 end


end
