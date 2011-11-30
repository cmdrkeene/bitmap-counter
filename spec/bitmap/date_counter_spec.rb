require 'spec_helper'

describe Bitmap::DateCounter do
  let(:counter) { Bitmap::DateCounter.new("test") }

  before do
    counter.delete
  end

  it "defaults to today" do
    counter.count(1)
    counter.counted?(1).should be_true
    counter.unique.should == 1
  end

  it "reuses redis connections" do
    lambda {
      Bitmap::Counter.new("test")
      Bitmap::Counter.new("test")
      Bitmap::DateCounter.new("test")
    }.should_not change { Bitmap::Counter.redis.info["connected_clients"] }
  end

  describe "with multiple days of data" do
    before do
      counter.count(1, Date.today)
      counter.count(3, Date.today)
      counter.count(7, Date.today)
      counter.count(1, Date.today - 1)
    end

    it "returns counted? for an id on a date" do
      counter.counted?(3, Date.today).should be_true
      counter.counted?(3, Date.today - 1).should be_false

      counter.counted?(1, Date.today).should be_true
      counter.counted?(1, Date.today - 1).should be_true
    end

    it "returns number of unique ids for specific dates" do
      counter.unique(Date.today).should == 3
      counter.unique(Date.today - 1).should == 1
    end

    it "returns number of unique ids for a date range" do
      counter.unique((Date.today - 1)..Date.today).should == 3
    end

    it "is not affected by out of range errors" do
      counter.unique((Date.today - 2)..Date.today).should == 3
    end
  end
end
