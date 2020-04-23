class ShiftJob < ApplicationRecord
  belongs_to :shift
  belongs_to :job
  
   # Scopes
  scope :alphabetical, -> { joins(:job).order('name') }
  
  # Validations
  validates_presence_of :shift_id, :job_id
  validate :past_shift_job
  validate :active_job
  
  private
  def past_shift_job
    all_shifts_past = Shift.past.map(&:id)
    unless all_shifts_past.include?(self.shift_id)
      errors.add(:shift, "is not a past shift")
    end
  end
  
  def active_job
      all_active_job = Job.active.map(&:id)
      unless all_active_job.include?(self.job_id)
        errors.add(:job, "is not an active job in the system")
      end
  end
  
end
