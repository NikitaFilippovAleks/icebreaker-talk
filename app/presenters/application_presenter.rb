# frozen_string_literal: true

# Абстрактный класс. Описывает основное поведение презентеров
class ApplicationPresenter
  include Rails.application.routes.url_helpers

  attr_reader :record, :view

  # Инициализация презентера
  #
  # @param [Object] Дополнительный контекст для отображения
  #
  # @example Создание презентера для модели
  #
  # @example_return UserPresenter.new(user, view_context)
  def initialize(record, errors = {}, view = nil)
    @record = record
    @errors = errors
    @view = view
  end

  # Вывод данных об ошибках
  #
  # @return [Hash] Хэш, содержащий ошибки валидации записи
  #
  # @example presenter.data_errors
  #
  # @example_return { errors: { email: ["Не может быть пустым"] } }
  def data_errors
    # Если в презентер не был явно передан заполненный объект ошибок,
    # то смотрим ошибки ActiveRecord на объекте модели
    errors_to_present = @errors.empty? ? @record.errors : @errors

    { errors: errors_to_present.messages }
  end

  # Вывод данных с помощью переданного метода презентера по каждой записи переданного массива
  #
  # @return [Array] - массив результатов выполнения методов презентера для каждой записи
  #
  # @example presenter.present_records(User.all, :main)
  #
  # @example_return [{ id: "123", email: "example@mail.ru", ... }, { ... }]
  def present_records(records, presenter_method)
    records.map { |r| r.present(view).send(presenter_method) }
  end

  # Метод для получения url прикреплённого файла
  #
  # @param attachment [ActiveStorage::Attached::One] Поле прикреплённого файла
  #
  # @param style [Symbol] Вариант прикреплённого файла
  #
  # @return [String] url прикреплённого файла
  #
  # @return [nil:NilClass] Если нет прикреплённого файла
  #
  # @example ApplicationPresenter.new(Model.first).file_url(Model.first.image, :style)
  #
  # @example_return "http://*host*/rails/active_storage/representations/redirect/*...*/images/image.png"
  def file_url(file_field, style = nil)
    return if file_field.blank?

    return url_for(file_field.variant(style)) if style.present? && style != :original

    url_for(file_field)
  end

  # Метод для получения массива urls прикреплённых файлов
  #
  # @param file_fields [ActiveStorage::Attached::Many] Поле прикреплённых файлов
  #
  # @param style [Symbol] Вариант прикреплённого файла
  #
  # @return [Array] Массив urls  прикреплённых файлов
  #
  # @return [nil:NilClass] Если нет прикреплённых файлов
  #
  # @example ApplicationPresenter.new(Agent.first).files_urls(Agent.first.trade_licenses)
  #
  # @example_return [
  #   "http://*host*/rails/active_storage/blobs/redirect/*...*/doc1.pdf",
  #   "http://*host*/rails/active_storage/blobs/redirect/*...*/doc2.pdf"
  # ]
  def files_urls(files_field, style = nil)
    return [] if files_field.blank?

    files_field.map do |file|
      file_url(file, style)
    end
  end

  private

  # Метод для получения атрибутов записи, указанных в MODEL_ATTRIBUTES
  #
  # @return [Hash] Хэш с заданными атрибутами записи
  #
  # @example presenter.send(:properties)
  #
  # @example_return { id: "123", email: "example@mail.ru", ... }
  def properties
    record.attributes.symbolize_keys.slice(*self.class::MODEL_ATTRIBUTES)
  end
end
