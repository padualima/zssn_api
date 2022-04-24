class ErrorSerializer
  def initialize(resource)
    @messages = resource.errors.full_messages.first
    @field = resource.model_name.collection
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
