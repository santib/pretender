ActiveRecord::Schema.define do
  create_table :admin_users do |t|
    t.string :name
  end

  create_table :users do |t|
    t.string :name
  end
end
