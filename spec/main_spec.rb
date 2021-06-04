require "spec_helper"
require "fileutils"
require_relative "../main.rb"

RSpec.describe "main file" do
  it "generate expected file" do
    system %(ruby main.rb)

    file1 = File.open("./output.json").read.gsub!(" ","").gsub!("\n", "")
    file2 = File.open("./data/expected_output.json").read.gsub!(" ","").gsub!("\n", "")

    expect(file1).to eql(file2)
  end

  describe "find_car" do
    it "return expected car with id" do
      cars = [{"id"=>1, "price_per_day"=>2000, "price_per_km"=>10}, {"id"=>2, "price_per_day"=>3000, "price_per_km"=>15}, {"id"=>3, "price_per_day"=>1700, "price_per_km"=>8}]
      id = 2

      expect(find_car(cars, id)).to eql({ "id"=> 2, "price_per_day"=> 3000, "price_per_km"=> 15 })
    end
  end

  describe "time_price" do
    it "return  6665€ for 5 days at 1333€/day" do
      start_date = "2017-01-1"
      end_date = "2017-01-5"
      price_per_day = 1333

      expect(time_price(start_date, end_date, price_per_day)).to eql(6665)
    end

    it "return  6000€ for 3 days at 2000€/day" do
      start_date = "2017-12-8"
      end_date = "2017-12-10"
      price_per_day = 2000

      expect(time_price(start_date, end_date, price_per_day)).to eql(6000)
    end
  end
end