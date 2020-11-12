namespace :sync do
  desc 'Sync with the current report'
  task current: :environment do
    State.sync
  end

  desc 'Sync with the historical reports'
  task full: :environment do
    State.sync(historical: true)
  end
end
