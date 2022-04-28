class RecordSerializer < ActiveModel::Serializer
  attributes :id
  attribute :record_status do
    object.kind
  end
  attribute :reported_survivor do
    {
      id: object.survivor.id,
      name: object.survivor.name,
      gender: object.survivor.gender,
      actual_status: object.survivor.status,
      location: [
        object.by_survivor.location
      ]
    }
  end
  attribute :recorded_by_survivor do
    {
      id: object.by_survivor.id,
      name: object.by_survivor.name,
      gender: object.by_survivor.gender,
      actual_status: object.by_survivor.status,
      location: [
        object.by_survivor.location
      ]
    }
  end
end
