# frozen_string_literal: true

module ExceptionHandler # :nodoc:
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      details = { status: 404, error: 'Not found', message: e.message }
      json_response(details, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      details = { status: 422, error: 'Validation error', message: e.message }
      json_response(details, :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do |e|
      details = { status: 400, error: 'Bad request', message: e.message }
      json_response(details, :invalid_param)
    end

    rescue_from CustomExceptions::InvalidRequestError do |e|
      details = { status: 400, error: 'Bad request', message: e.message }
      json_response(details, :invalid_request)
    end
  end
end
