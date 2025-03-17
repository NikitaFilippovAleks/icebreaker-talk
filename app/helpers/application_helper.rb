# frozen_string_literal: true

# Базовый хелпер приложения
module ApplicationHelper
  include Pagy::Backend

  require 'pagy/extras/metadata'

  # Подготовка данных для вывода в json-контроллеры
  #
  # @param records [Array] Массив записей, которые требуется представить в формате json.
  # @param root_name [Symbol, String] Название ключа в результирующем хэше.
  # @param presenter_method [Symbol, String] Метод презентера, который будет использоваться.
  # @param pagination_params [Hash] Параметры пагинации, такие как количество элементов на странице и номер страницы.
  #
  # @return [Hash] Хэш с данными, представленными в формате json
  #
  # @example json_presented(User.all, :users, :main)
  #
  # @example_return { users: [{ id: "123", email: "example@mail.ru" }, { id: "1234", email: "example2@mail.ru" }] }
  def json_presented(records, root_name, presenter_method, errors: {}, pagination_params: {})
    return { "#{root_name}": [] } if records.blank?

    data_paginate = {}
    records_after_paginate = records

    # Если переданы параметры пагинации, добавьте пагинацию
    if pagination_params.present?
      pagy, records_after_paginate = pagy(records, limit: pagination_params[:per_page], page: pagination_params[:page])

      data_paginate = { pagination: pagy_metadata(pagy) }
    end

    # Данные презентации с переданным методом презентера
    records_presented =
      if records.is_a?(ActiveRecord::Relation) || records.is_a?(Array)
        records_after_paginate.map { |b| present_as_json(b, presenter_method, errors) }
      else
        present_as_json(records, presenter_method, errors)
      end

    # Создание хэша с данными для вывода в формате json
    { "#{root_name}": records_presented }.merge(data_paginate)
  end

  private

  # Представление переданной записи методом, переданным презентером, и преобразование в формат json
  #
  # @param record [ActiveRecord::Base] Запись, которую нужно представить в JSON.
  # @param presenter_method [Symbol] Метод презентера для форматирования записи в JSON.
  #
  # @return [Hash, nil] Хэш с данными записи в формате json или nil, если запись пустая
  #
  # @example present_as_json(User.first, :main)
  #
  # @example_return { id: "123", email: "example@mail.ru" }
  def present_as_json(record, presenter_method, errors = {})
    return if record.blank?

    record.present(errors).send(presenter_method).as_json
  end
end
