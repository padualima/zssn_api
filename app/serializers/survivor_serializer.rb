class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :status
  has_one :location_feature
end
