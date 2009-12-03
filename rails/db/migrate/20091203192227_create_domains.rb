class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.integer :adminid
      t.string :dnsname
      t.string :dnsname_idn
      t.string :comment
      t.integer :state

      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
