module EnvironmentHelper
  def api_headers(version: 1)
    {
      'Accept' => "application/vnd.zssn.v#{version}"
    }
  end

  def api_payload(resource, nests = [])
    excepts = %w[created_at updated_at]
    attributes = {}
    attributes['data'] = {}

    attributes['data']['attributes'] = delete_attribute(resource.attributes, excepts)

    if nests.any?
      nests.each do |n|
        attributes['data']['attributes']
          .merge!(
            "#{n.model_name.param_key}_attributes" => delete_attribute(n.attributes, excepts)
          )
      end
    end

    attributes
  end

  def reject_payload(payload, key, nested=nil)
    delete_payload(payload['data']['attributes'], key)

    if nested&.match?(/_attributes/)
      delete_payload(payload['data']['attributes']["#{nested}"], key)
    end
  end

  private

  def delete_attribute(attributes, excepts)
    attributes.delete_if { |k,_| k.in?(excepts) || k.match?(/id/) }
  end

  def delete_payload(payload, key)
    payload.delete_if { |k,_| k.eql?(key) }
  end
end
