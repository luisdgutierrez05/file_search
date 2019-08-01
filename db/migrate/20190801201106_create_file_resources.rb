class CreateFileResources < ActiveRecord::Migration[5.2]
  def change
    create_table :file_resources, id: :uuid do |t|
      t.string :name
      t.text :tags, array: true, default: []

      t.timestamps
    end

    add_index :file_resources, :tags, using: 'gin'
  end
end
