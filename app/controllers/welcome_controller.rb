class WelcomeController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @total_question = Question.count
    @total_answer = Answer.count
    @total_user = User.count
    @total_api_call = Tenant.sum(:api_call_count)
  end
end
