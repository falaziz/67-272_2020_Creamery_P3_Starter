FactoryBot.define do
  factory :pay_grade_rate do
    pay_grade { nil }
    rate { 1.5 }
    start_date { "2020-04-22" }
    end_date { "2020-04-22" }
  end
end
