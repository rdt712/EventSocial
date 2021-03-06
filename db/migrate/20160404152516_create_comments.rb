class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer		:user_id		
    	t.integer		:event_id
    	t.string		:comment
    	t.boolean 		:approved, :default => true

    	t.timestamps	null: false
    end
  end
end