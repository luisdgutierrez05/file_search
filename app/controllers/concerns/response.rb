# frozen_string_literal: true

module Response # :nodoc:
  def json_response(object, status = :ok, meta = nil)
    render json: object, meta: meta, status: status
  end
end
