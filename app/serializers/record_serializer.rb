class RecordSerializer < ActiveModel::Serializer
  attributes :id, :kind, :by_survivor
  belongs_to :survivor
end
