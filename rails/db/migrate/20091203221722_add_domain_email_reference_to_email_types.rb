class AddDomainEmailReferenceToEmailTypes < ActiveRecord::Migration
  def self.up
    add_column :domain_emails, :domain_email_type_id, :integer
  end

  def self.down
    remove_column :domain_emails, :domain_email_type_id
  end
end
