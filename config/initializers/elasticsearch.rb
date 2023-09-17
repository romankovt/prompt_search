# frozen_string_literal: true

# Enable logging
log = ActiveModel::Type::Boolean.new.cast(ENV.fetch('LOG_ELASTICSEARCH', nil))
client = Elasticsearch::Client.new(
  host: ENV.fetch('ELASTICSEARCH_URL', nil),
  log:
)
Elasticsearch::Model.client = client
