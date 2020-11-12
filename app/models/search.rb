class Search < ApplicationRecord
  validates :start, :end, presence: true
  validates :end, uniqueness: { scope: :start }
  validate :end_cannot_be_before_start

  def results
    Report.select('
      state_id,
      max(positive) as max_cases,
      min(positive) as min_cases,
      max(positive) - min(positive) as change_in_cases,
      max(deaths) as max_deaths,
      min(deaths) as min_deaths,
      max(deaths) - min(deaths) as change_in_deaths
    ').where(date: start..self.end).group(:state_id).as_json(except: [:id])
  end

  def end_cannot_be_before_start
    if self.end.present? && start.present? && self.end < start
      errors.add(:end, "can't be before start")
    end
  end
end
