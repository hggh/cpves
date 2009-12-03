class DomainEmail < ActiveRecord::Base
  belongs_to :domain
  belongs_to :domain_email_type
end
