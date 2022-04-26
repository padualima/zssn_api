class ErrorSerializer
  def initialize(exception = nil, resource)
    @messages = exception.nil? ? resource.errors.full_messages : [exception.message]
    @field = exception.nil? ? resource.model_name.collection : exception.model.underscore
  end

  def to_json(*)
    response = { errors: errors }
    response.to_json
  end

  private

  def errors
    {
      field: @field,
      message: @messages
    }
  end
end
