# frozen_string_literal: true

class PromptSearchService < BaseService
  attr_accessor :query

  include Elasticsearch::DSL

  def call(params)
    q = params[:query]&.downcase
    @page = params[:page] || 1

    definition = search do
      query do
        bool do
          if q.present?
            # boosting exact matches prefixes
            should do
              match_phrase_prefix text: { query: q, boost: 3 }
            end

            # boosting exact matches but anywhere in the text
            should do
              match_phrase text: { query: q, boost: 2 }
            end

            # fuzzy searching with least priority
            should do
              match text: { query: q, fuzziness: 'AUTO' }
            end

            # at least 1 should clause should match
            minimum_should_match 1
          else
            # no query -> return all results
            must { match_all }
          end
        end
      end
    end

    @prompts = Prompt.search(definition).page(@page)
    @total = @prompts.records.total
    @prompts = @prompts.records
  end
end
