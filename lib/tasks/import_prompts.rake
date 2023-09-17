# frozen_string_literal: true

namespace :db do
  desc 'Parse db/seed_data/prompts.csv, populate the Prompt model and index records to elasticsearch'
  task import_prompts: :environment do
    require 'csv'

    file_path = Rails.root.join('db', 'seed_data', 'prompts.csv')

    Prompt.__elasticsearch__.create_index!(force: true)
    prompts_before_count = Prompt.count
    new_prompts = []

    puts 'Importing prompts to the database...'

    CSV.foreach(file_path, headers: true).with_index do |row, index|
      if (index % 500).zero?
        print '.'
        Prompt.insert_all(new_prompts) if new_prompts.any?
        new_prompts = []
      end

      new_prompts << { text: row['prompt'] }
    end

    puts
    puts "#{Prompt.count - prompts_before_count} imported."
    puts 'Indexing prompts to elasticsearch...'
    Prompt.import
  end
end
