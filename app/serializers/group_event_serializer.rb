class GroupEventSerializer

  include JSONAPI::Serializer

  attribute :name
  attribute :description
  attribute :starts_at
  attribute :ends_at
  attribute :duration
  attribute :location
  attribute :status
  
end
