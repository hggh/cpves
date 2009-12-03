class CreateDomainEmails < ActiveRecord::Migration
  def self.up
    create_table :domain_emails do |t|
      t.string :address
      t.integer :state
      t.string :address_fullname
      t.references :domain

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_emails
  end
end
