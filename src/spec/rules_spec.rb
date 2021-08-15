require_relative "../services/rules"
require "rspec/core"

describe Rules do
  let(:items) do
    [
      {
        item_code: "GR1",
        price: 3.11,
        rule: "CEO"
      },
      {
        item_code: "SR1",
        price: 5.00,
        rule: 'COO'
      },
      {
        item_code: "CF1",
        price: 11.23,
        rule: "CTO"
      }
    ]
  end

  subject do
    Rules.new(items[0], 3)
  end

  describe "#apply_rules" do
    it "call buy_one_get_one method and aplly rule" do
      expect(subject).to receive(:buy_one_get_one) { 6.22 }
      result = subject.apply_rules
      expect(result).to eq(6.22)
    end
  end

  describe "#buy_one_get_one" do
    it "should apply this rule to the correct item" do
      subject = Rules.new(items[0], 4)
      result = subject.apply_rules
      expect(result).to eq(6.22)
    end
  end

  describe "#discount_bulk" do
    it "should apply bulk rule to the correct item" do
      subject = Rules.new(items[1], 4)
      result = subject.apply_rules
      expect(result).to eq(18)
    end
  end

  describe "#discount_bulk" do
    it "should apply bulk rule to the correct item" do
      subject = Rules.new(items[2], 4)
      result = subject.apply_rules
      expect(result).to eq(29.94666666666667)
    end
  end
end
