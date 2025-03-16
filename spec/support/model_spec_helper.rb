# frozen_string_literal: true

# Model spec helper
module ModelSpecHelper
  # Матчер вызывающий valid? на переданной записе и проверяющий
  # наличие переданного сообщения об ошибке в переданном поле
  RSpec::Matchers.define :has_validation_errors do |field, message, exec_valid = true|
    # Основной метод матч в котором происходит вызов valid? и проверка сообщения
    match do |record|
      record.valid? if exec_valid

      message_expected = message.is_a?(Array) ? message : [message]

      record.errors.messages[field] == message_expected
    end

    # Сообщение об успешном прохождении матчера
    description do
      "should has errors on #{field} field with message '#{message}'"
    end

    failure_message do |record|
      "expected error on field #{field}: '#{message}', got: #{record.errors.messages[field]}"
    end
  end

  # Матчер вызывающий valid? на переданной записе и проверяющий
  # наличие только переданного ключа ошибки
  RSpec::Matchers.define :has_only_errors_keys do |*keys|
    # Основной метод матч в котором происходит вызов valid? и проверка ключа
    match do |record|
      record.valid?

      # Если больше одного ключа ошибок, то возвращаем false
      record.errors.attribute_names.sort == keys.sort
    end

    # Сообщение об успешном прохождении матчера
    description do
      "should has only '#{keys.join(', ')}' key"
    end
  end
end
