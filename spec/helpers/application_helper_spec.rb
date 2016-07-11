require "spec_helper"

describe ApplicationHelper do
  describe "nice_date > " do
    it "returns N/A for nil date" do
      nd = nice_date(nil)
      expect(nd).to eq "N/A"
    end

    it "returns nicely formatted for non-nil date" do
      dt = Date.new(2016,7,4)
      expect(nice_date(dt)).to eq "July  4, 2016"
    end

  end 

  describe "nice_datetime > " do
    it "returns N/A for nil datetime" do
      ndt = nice_datetime(nil)
      expect(ndt).to eq "N/A"
    end

    it "returns nicely formatted for non-nil datetime" do
      dt = DateTime.iso8601('2001-02-03T04:05:06+07:00')
      expect(nice_datetime(dt)).to eq "February  3, 2001  4:02 am"
    end

  end 

end