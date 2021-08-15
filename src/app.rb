require_relative "../src/controllers/checkout"

pricing_rules = [
  { item_code: "GR1", price: 3.11, rule: "CEO" },
  { item_code: "SR1", price: 5.00, rule: "COO" },
  { item_code: "CF1", price: 11.23, rule: "CTO" }
]

co = Checkout.new(pricing_rules)
co.scan("GR1")
co.scan("CF1")
co.scan("SR1")
co.scan("CF1")
co.scan("CF1")

price = co.total

puts "Your purchase list is: #{co.checkout_list}"
puts "Total to pay: £#{price}"
