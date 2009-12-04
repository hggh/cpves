# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091203224403) do

  create_table "domain_email_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domain_emails", :force => true do |t|
    t.string   "address"
    t.integer  "state"
    t.string   "address_fullname"
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "domain_email_type_id"
  end

  create_table "domains", :force => true do |t|
    t.integer  "adminid"
    t.string   "dnsname"
    t.string   "dnsname_idn"
    t.string   "comment"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "p_active",     :limit => 1, :default => 1, :null => false
    t.integer  "p_imap",       :limit => 1, :default => 1, :null => false
    t.integer  "p_pop3",       :limit => 1, :default => 1, :null => false
    t.integer  "p_webmail",    :limit => 1, :default => 1, :null => false
    t.integer  "max_emails",                :default => 0, :null => false
    t.integer  "max_forwards",              :default => 0, :null => false
    t.integer  "max_mlists",                :default => 0, :null => false
  end

end
