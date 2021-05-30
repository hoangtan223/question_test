class QuestionsController < ApplicationController
  def index
    questions = Question.where(private: false).includes(answers: [:user])

    render json: questions
  end
end
