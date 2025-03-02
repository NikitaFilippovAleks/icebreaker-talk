# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApplicationHelper

  # Выводим сообщение об ошибке, если запись не найдена
  #
  # @return [nil]
  #
  # @example not_found
  #
  # @example_return { "error": "Запись с таким id не найдена." }
  def not_found
    render json: { errors: ['Запись с таким id не найдена.'] }, status: :not_found
  end
end
