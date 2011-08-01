class CreatePasswords < ActiveRecord::Migration
  def self.up
    create_table :passwords do |t|
      t.string :user
      t.string :salt
      t.string :hmac
      t.string :title
      t.datetime :last_used

      t.timestamps
    end
  end

  def self.down
    drop_table :passwords
  end
end
