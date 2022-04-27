class NearestSurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :status, :location

  has_one :nearest_survivor
end
