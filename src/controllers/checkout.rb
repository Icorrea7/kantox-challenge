require_relative '../../src/services/rules'

class Checkout
  # before_action :check_rules, only: :total
  attr_reader :checkout_list, :pricing_rules

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @checkout_list = []
  end

  def scan(item)
    return "Ups!! #{item} is not valid" unless pricing_rules.any? { |i| i[:item_code] == item }

    checkout_list.push(item)
  end

  def total
    total = 0
    checked = []
    checkout_list.each do |item|
      next if checked.include?(item)

      item_type = check_item_type(item)
      num_items = checkout_list.count(item)
      total += check_rules(item_type, num_items)
      checked.push(item)
    end
    total
  end

  private

  def check_rules(item_type, num_items)
    return (item_type[:price] * num_items) if item_type[:rule].nil?

    Rules.new(item_type, num_items).apply_rules
  end

  def check_item_type(item)
    pricing_rules.select { |i| i[:item_code] == item }.first
  end
end
