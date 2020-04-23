class PayGrade < ApplicationRecord
  has_many :assignments
  has_many :pay_grade_rates
  
  validates_presence_of :level
  
  scope :alphabetical, -> { order('level') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where.not(active: true) }
  
  # Other methods
  def make_active
    self.active = true
    self.save!
  end

  def make_inactive
    self.active = false
    self.save!
  end
end
