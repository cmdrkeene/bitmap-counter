require 'spec_helper'

describe Bitmap::Counter do
  let(:counter) { Bitmap::Counter.new("test") }

  before do
    counter.delete
    counter.count(1)
    counter.count(3)
    counter.count(7)
  end

  describe ".redis" do
    it "uses a supplied redis instance" do
      counter.counted?(1).should be_true

      other_redis = Redis.new
      other_redis.select(1)

      Bitmap::Counter.redis = other_redis
      Bitmap::Counter.redis.should == other_redis

      other_counter = Bitmap::Counter.new("test")
      other_counter.delete

      other_counter.count(2)
      other_counter.counted?(1).should be_false
      other_counter.counted?(2).should be_true
    end
  end

  describe "#unique" do
    it "returns the sum of all unique ids" do
      counter.unique.should == 3 # "10001010"
    end
  end

  describe "#counted?" do
    it "returns true/false if id has been counted" do
      counter.counted?(1).should be_true
      counter.counted?(2).should be_false
      counter.counted?(3).should be_true
      counter.counted?(7).should be_true
      counter.counted?(99).should be_false
    end
  end
end
