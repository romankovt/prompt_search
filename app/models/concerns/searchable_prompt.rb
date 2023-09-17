# frozen_string_literal: true

module SearchablePrompt
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    settings do
      mapping do
        indexes 'text', analyzer: 'english'
      end
    end

    def as_indexed_json(_options = {})
      as_json(only: :text)
    end
  end
end
