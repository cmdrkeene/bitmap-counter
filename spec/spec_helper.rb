require "rubygems"
require "bundler/setup"
Bundler.require :default, :development

require_relative "../lib/bitmap_counter"

RSpec.configure do |config|
  config.before(:each) do
    # ???
  end
end
