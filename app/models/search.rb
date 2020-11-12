class Search < ApplicationRecord
  validates :start, :end, presence: true
  validates :end, uniqueness: { scope: :start }
  validate :end_cannot_be_before_start

  def results
    Report.select('state_id, max(deaths) as max_deaths, avg(deaths) as avg_deaths').group(:state_id).as_json
  end

  def end_cannot_be_before_start
    if self.end.present? && start.present? && self.end < start
      errors.add(:end, "can't be before start")
    end
  end
end
