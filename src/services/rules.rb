class Rules
  attr_reader :item, :num_items

  def initialize(item, num_items)
    @item = item
    @num_items = num_items
  end

  def apply_rules
    case item[:rule]
    when 'CEO'
      buy_one_get_one
    when 'COO'
      discount_bulk
    when 'CTO'
      coffee_addicted
    end
  end

  def buy_one_get_one
    @num_items += 1 unless num_items.even?
    item[:price] * (@num_items / 2)
  end

  def discount_bulk
    return (item[:price] * @num_items) if @num_items < 3

    price = item[:price] - 0.5
    price * @num_items
  end

  def coffee_addicted
    return (item[:price] * @num_items) if @num_items < 3

    price = item[:price] * 2 / 3
    price * @num_items
  end
end
