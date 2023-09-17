# frozen_string_literal: true

class PromptSearchesController < ApplicationController
  def index
    service = PromptSearchService.new
    @prompts = service.call(params)
  end
end
