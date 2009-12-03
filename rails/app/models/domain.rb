class Domain < ActiveRecord::Base
  validates_uniqueness_of :dnsname
end
