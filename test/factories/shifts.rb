FactoryBot.define do
  factory :shift do
    assignment { nil }
    date { "2020-04-22" }
    start_time { "2020-04-22 17:15:00" }
    end_time { "2020-04-22 17:15:00" }
    notes { "MyText" }
    status { "MyString" }
  end
end
