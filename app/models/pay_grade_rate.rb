class PayGradeRate < ApplicationRecord
  belongs_to :pay_grade
  validates_numericality_of :rate, greater_than: 0
  
  scope :chronological, -> { order('start_date ASC, end_date ASC') }
  scope :current,       -> { where('end_date IS NULL') }
  scope :past,          -> { where('end_date IS NOT NULL') }
  scope :for_pay_grade,  ->(pay_grade) { where("pay_grade_id = ?", pay_grade.id) }
  scope :for_date,      ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
end
