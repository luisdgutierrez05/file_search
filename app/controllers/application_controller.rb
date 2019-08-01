# frozen_string_literal: true

class ApplicationController < ActionController::API # :nodoc:
  include Response
  include ExceptionHandler
end
