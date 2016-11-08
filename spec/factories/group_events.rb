FactoryGirl.define do

  factory :group_event do
    name "MyString"
    description "MyText"
    starts_at "2016-11-08 08:18:48"
    ends_at "2016-11-09 08:18:48"
    location "MyString"
    status "draft"
    deleted false
  end

  trait :invalid do
    name nil
    description nil
    starts_at nil
    ends_at nil
    location nil
    status "draft"
    deleted false
  end

  trait :published do
    status "published"
  end

end
