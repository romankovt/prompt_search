# frozen_string_literal: true

class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.text :text, null: false
      t.timestamps
    end
  end
end
