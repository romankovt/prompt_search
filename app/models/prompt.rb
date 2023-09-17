# frozen_string_literal: true

class Prompt < ApplicationRecord
  validates :text, presence: true

  searchkick

  def search_data
    { text: }
  end
end
