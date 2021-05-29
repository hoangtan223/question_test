class QuestionsController < ApplicationController
  def index
    questions = Question.where(private: false).includes(:answers)

    render json: questions
  end
end
