class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.integer :author_id

      t.timestamps
    end
    add_index :publications, [:author_id, :created_at]
  end
end
