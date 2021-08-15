require_relative '../../src/controllers/checkout'
require 'rspec/core'

describe Checkout do
  let(:pricing_rules) do
    [
      {
        item_code: 'GR1',
        price: 3.11,
        rule: 'CEO'
      },
      {
        item_code: 'SR1',
        price: 5.00,
        rule: 'COO'
      },
      {
        item_code: 'CF1',
        price: 11.23,
        rule: 'CTO'
      }
    ]
  end
  subject do
    Checkout.new(pricing_rules)
  end

  describe '#scan' do
    it 'scan two corrects items and add it to checkout list' do
      subject.scan('GR1')
      subject.scan('CF1')
      result = subject.checkout_list
      expect(result).to eq(['GR1','CF1'])
    end

    it "scan an item that doesn't exist" do
      result = subject.scan('N0')
      expect(result).to eq('Ups!! N0 is not valid')
    end
  end

  describe '#total' do
    before do
      subject.scan('GR1')
      subject.scan('GR1')
    end

    it 'check the rules and calculates the total amount' do
      service = double
      expect(service).to receive(:apply_rules) { 3.11 }
      expect(Rules).to receive(:new).with( pricing_rules[0], 2) { service }
      result = subject.total
      expect(result).to eq(3.11)
    end
  end
end
