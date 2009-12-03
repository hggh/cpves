class AddDomainsLimitColumns < ActiveRecord::Migration
  def self.up
    add_column :domains, :p_active, :tinyint, :limit => 1, :default => 1, :null => false
    add_column :domains, :p_imap, :tinyint, :limit => 1, :default => 1, :null => false
    add_column :domains, :p_pop3, :tinyint, :limit => 1, :default => 1, :null => false
    add_column :domains, :p_webmail, :tinyint, :limit => 1, :default => 1, :null => false
    add_column :domains, :max_emails, :integer, :limit => 11, :default => 0, :null => false
    add_column :domains, :max_forwards, :integer, :limit => 11, :default => 0, :null => false
    add_column :domains, :max_mlists, :integer, :limit => 11, :default => 0, :null => false
  end

  def self.down
    remove_column :domains, :p_active
    remove_column :domains, :p_imap
    remove_column :domains, :p_pop3
    remove_column :domains, :p_webmail
    remove_column :domains, :max_emails
    remove_column :domains, :max_forwards
    remove_column :domains, :max_mlists
  end
end
