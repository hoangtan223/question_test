class QuestionsController < ApplicationController
  def index
    service = GetQuestionsService.new(params[:q])

    if service.call
      render json: service.data
    else
      head :not_found
      return
    end
  end
end
