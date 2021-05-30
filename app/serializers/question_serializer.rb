class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :answers

  class AnswerSerializer < ActiveModel::Serializer
    attributes :id, :body, :user

    def user
      object.user.slice(:id, :name)
    end
  end
end
