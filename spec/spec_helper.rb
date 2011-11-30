$: << '.' << './../lib'
require "rubygems"
require "bundler/setup"
Bundler.require :default, :development

require "redis_bitmap_counter"
require "redis_bitmap_date_counter"

RSpec.configure do |config|
  config.before(:each) do
    # ???
  end
end
