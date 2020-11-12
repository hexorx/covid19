class State < ApplicationRecord
  self.primary_key = 'code'
  self.per_page = 100

  has_many :reports

  validates :code, :name, presence: true, uniqueness: true
  validates :code, format: { with: /\A[a-z]{2}\z/ }

  def sync(historical: false)
    fetch_reports(historical: historical).each do |attrs|
      reports.find_or_initialize_by(date: attrs['date']).update(attrs)
    end
  end

  def seed
    reports.create!(fetch_reports(historical: true)) if reports.count.zero?
  end

  def fetch_reports(historical: false)
    range = historical ? 'daily' : 'current'
    [(self.class.fetch_from "/states/#{code}/#{range}.json")].flatten.map do |report|
      Report.sanitize report
    end
  end

  def self.sync(historical: false)
    all.each { |state| state.sync(historical: historical) }
  end

  def self.seed
    create!(fetch_meta) if count.zero?
    all.each(&:seed)
  end

  def self.fetch_meta
    states = fetch_from '/states/info.json'
    states.map do |state|
      state['code'] = state['state'].downcase
      state.keep_if { |k| [*attribute_names].include? k }
    end
  end

  def self.fetch_from(path)
    puts [Rails.configuration.feed_url, path].join
    JSON.parse (Faraday.get [Rails.configuration.feed_url, path].join).body
  end
end
