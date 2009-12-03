class CreateDomainEmailTypes < ActiveRecord::Migration
  def self.up
    create_table :domain_email_types do |t|
      t.string :name

      t.timestamps
    end
      DomainEmailTypes.create(:name => 'email')
      DomainEmailTypes.create(:name => 'forward')
      DomainEmailTypes.create(:name => 'mlist')
  end

  def self.down
    drop_table :domain_email_types
  end
end
