class CollectionPresenter < ApplicationPresenter
  MODEL_ATTRIBUTES = %i[id color description name created_at].freeze

  delegate(*MODEL_ATTRIBUTES, to: :record)
  delegate :questions, to: :record

  def main
    {
      id:,
      name:,
      color:,
      description:,
      questions_count: questions.count
    }
  end

  def detailed
    {
      id:,
      name:,
      color:,
      description:,
      questions_count: questions.count,
      questons: questions
    }
  end
end
