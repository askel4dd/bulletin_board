require 'coveralls'
Coveralls.wear!
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara-screenshot/minitest'

class ActiveSupport::TestCase
  fixtures :all
  Warden.test_mode!
  Capybara.default_driver = :poltergeist
  Capybara.default_wait_time = 7
  include Warden::Test::Helpers
  include Capybara::DSL

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end

end
