class Shift < ApplicationRecord
  belongs_to :assignment
  has_one :employee, through: :assignment
  has_one :store, through: :assignment
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  
  # Scopes
  scope :completed,       -> { where('end_time IS NOT NULL') }
  scope :incomplete,          -> { where('end_time IS NULL') }
  scope :by_store,      -> { joins(:store).order('name') }
  scope :by_employee,   -> { joins(:employee).order('last_name, first_name') }
  scope :chronological, -> { order('date ASC, start_time ASC') }
  scope :past,      -> { where("date < ?", Date.current) }
  scope :upcoming,      -> { where("date >= ?", Date.current) }
  scope :pending,      -> { where("status = ?", 'pending') }
  scope :started,      -> { where("status = ?", 'started') }
  scope :finished,      -> { where("status = ?", 'finished') }
  
  scope :for_store,     ->(store) { joins(:store).where("store_id = ?", store.id) }
  scope :for_employee,  ->(employee) { joins(:employee).where("employee_id = ?", employee.id) }
  scope :for_next_days,  ->(x) { where("date >= ? AND date <= ?", Date.current, Date.current + x) }
  scope :for_past_days,  ->(x) { where("date < ? AND date >= ?", Date.current, x.days.ago.to_date) }
  
  # Validations
  validates_presence_of :assignment_id
  validates_inclusion_of :status, in: %w[pending started finished], message: 'is not an option'
  validates_time :start_time, allow_nil: false
  validates_time :end_time, allow_nil: true, :after => :start_time
  validates_date :date, allow_nil: false
  validate :valid_assignment
  # validate :assignment_start_date
  
  #Callbacks
  before_create :set_end_time
  
  STATUS_LIST = [['Pending', 'pending'],['Started', 'started'],['Finished', 'finished']].freeze
  
  private
  def set_end_time
    if self.end_time.nil? 
        self.end_time = self.start_time + 3.hours 
    end
  end
  
  def valid_assignment
    all_assignments = Assignment.current.map(&:id)
    unless all_assignments.include?(self.assignment_id)
      errors.add(:assignment, "is not a current assignment in the system")
    end
  end
  
  def assignment_start_date
      @sdate = Assignment.find(self.assignment_id)
      unless @sdate.start_date <= self.date
        errors.add("date invalid")
      end
  end
end
