require "spec_helper"

RSpec.describe Babylon do

  it "Calculates total #1" do
    co = Babylon::Checkout.new
    co.scan("001")
    co.scan("002")
    co.scan("003")
    expect(co.grand_total).to eq(66.78)
  end

  it "Calculates total #2" do
    co = Babylon::Checkout.new
    co.scan("001")
    co.scan("003")
    co.scan("001")
    expect(co.grand_total).to eq(36.95)
  end

  it "Calculates total #3" do
    co = Babylon::Checkout.new
    co.scan("001")
    co.scan("002")
    co.scan("001")
    co.scan("003")
    expect(co.grand_total).to eq(73.76)
  end

end
