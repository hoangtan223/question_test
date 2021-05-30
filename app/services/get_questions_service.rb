class GetQuestionsService
  attr_reader :query, :data

  def initialize(query_params)
    @query = query_params
  end

  def call
    if query.present?
      @data = matched_questions
      data.any?
    else
      @data = Question.available
      true
    end
  end

  private

  def matched_questions
    Question.available.where("title LIKE ?", "%#{query}%")
  end
end
