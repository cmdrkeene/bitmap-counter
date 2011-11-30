require 'spec_helper'

describe RedisBitmapCounter do
  let(:counter) { RedisBitmapCounter.new("test") }

  before do
    counter.delete
    counter.count(1)
    counter.count(3)
    counter.count(7)
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
