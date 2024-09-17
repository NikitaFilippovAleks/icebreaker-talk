# frozen_string_literal: true

# Хэлпер для тестирования контроллера
module ControllerSpecHelpers
  # Парсинг json из body из ответа сервера
  def json_response
    JSON.parse(response.body).deep_symbolize_keys
  end

  # Авторизация
  def login(user)
    return if user.blank?

    add_success_headers_to_request(user)
  end

  private

  # Добавляем в header реквеста новые headers для успешного подтверждения пользователя
  # при запросе к данным апи-контроллеров
  def add_success_headers_to_request(user)
    # Создаем headers с типом запроса и к нему добавляем все поля
    # сгенерированные на основе данных пользователя
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    headers.merge! user.create_new_auth_token
    request.headers.merge! headers
  end
end
