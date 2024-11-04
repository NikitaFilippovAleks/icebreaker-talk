# frozen_string_literal: true

# Questions table creation
class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :text
      t.references :collection, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
