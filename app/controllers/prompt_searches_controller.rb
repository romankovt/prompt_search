# frozen_string_literal: true

class PromptSearchesController < ApplicationController
  def index
    @prompts = Prompt.search(params[:query], page: params[:page], per_page: 20)
  end
end
