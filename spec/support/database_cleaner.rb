# frozen_string_literal: true

require 'database_cleaner'

RSpec.configure do |config|
  # Ensure Suite is set to use transactions for speed.
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  # Before each spec check if it is a Javascript test and switch between
  # using database transactions or not where necessary.
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.before(:each) do |example|
    if RSpec.current_example.metadata[:js]
      page.driver.browser.url_blacklist = ['http://fonts.googleapis.com']
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end

    DatabaseCleaner.start

    Spree::Api::Config[:requires_authentication] = true
    Spree::Config.reset
  end

  # After each spec clean the database.
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, type: :job) do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  config.after(:each, type: :feature) do |example|
    missing_translations = page.body.scan(/translation missing: #{I18n.locale}\.(.*?)[\s<\"&]/)
    if missing_translations.any?
      puts "Found missing translations: #{missing_translations.inspect}"
      puts "In spec: #{example.location}"
    end
  end
end
