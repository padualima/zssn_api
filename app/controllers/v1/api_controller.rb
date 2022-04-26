class V1::ApiController < ApplicationController
  # define :bad_request, :not_found, :unprocessable_entity, :not_acceptable, :forbidden, :unauthorized
  def render_save_error!(object, status)
    render json: ErrorSerializer.new(object), status: status
  end
end
