# frozen_string_literal: true

# Collections table creation
class CreateCollections < ActiveRecord::Migration[7.2]
  def change
    create_table :collections, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :color

      t.timestamps
    end
  end
end
