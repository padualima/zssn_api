class V1::ApiController < ApplicationController
  # define :bad_request, :not_found, :unprocessable_entity, :not_acceptable, :forbidden, :unauthorized
  def render_save_error!(object, status)
    render json: ErrorSerializer.new(object), status: status
  end

  def render_exception_error!(exception, status)
    render json: ErrorSerializer.new(exception, nil), status: status
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_exception_error!(exception, :not_found)
  end
end
