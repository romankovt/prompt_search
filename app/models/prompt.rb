# frozen_string_literal: true

class Prompt < ApplicationRecord
  include SearchablePrompt

  validates :text, presence: true
end
