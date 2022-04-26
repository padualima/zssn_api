class NearestSurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :status

  has_one :nearest_survivor
end
