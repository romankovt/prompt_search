# frozen_string_literal: true

class PromptSearchService < BaseService
  attr_accessor :query

  include Elasticsearch::DSL

  def call(params)
    q = params[:query]&.downcase
    @page = params[:page] || 1
    @per_page = params[:per_page] || 10

    definition = search do
      query do
        bool do
          if q.present?
            # fuzzy search
            should do
              multi_match do
                query q
                fields(['text'])
                fuzziness 'auto'
              end
            end

            # boosting exact matches
            should do
              match_phrase_prefix text: { query: q, boost: 3 }
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
