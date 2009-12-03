class Domain < ActiveRecord::Base
  validates_presence_of :dnsname
  validates_uniqueness_of :dnsname
  
  has_many :domain_emails
end
