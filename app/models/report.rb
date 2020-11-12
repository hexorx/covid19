class Report < ApplicationRecord
  belongs_to :state

  validates :state, :date, presence: true
  validates :date, uniqueness: {
    scope: :state_id, message: 'should only have one report per day per state'
  }

  def self.sanitize(attrs)
    {
      'date' => attrs['date'],
      'state_id' => attrs['state'].downcase,
      'deaths' => attrs['death'],
      'hospitalized' => attrs['hospitalizedCurrently'],
      'positive' => attrs['positive']
    }
  end
end
