class Job < ApplicationRecord
    has_many :shift_jobs
    has_many :shifts, through: :shift_jobs
    
    # Scopes
    scope :alphabetical, -> { order('name') }
    scope :active,       -> { where(active: true) }
    scope :inactive,     -> { where.not(active: true) }
  
    validates_presence_of :name
    
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
