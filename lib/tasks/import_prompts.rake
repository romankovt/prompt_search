# frozen_string_literal: true

namespace :db do
  desc 'Parse db/seed_data/prompts.csv, populate the Prompt model and index records to elasticsearch'
  task import_prompts: :environment do
    require 'csv'

    file_path = Rails.root.join('db', 'seed_data', 'prompts.csv')
    prompts = []

    CSV.foreach(file_path, headers: true).with_index do |row, index|
      if (index % 500).zero?
        print '.'
        Prompt.insert_all(prompts) if prompts.any?
        prompts = []
      end

      prompts << { text: row['prompt'] }
    end

    puts 'Indexing prompts to elasticsearch...'
    Prompt.reindex
  end
end
