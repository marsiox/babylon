require "babylon/version"

module Babylon

  ITEMS = [
    { code: "001", name: "Lavender heart", price: 9.25 },
    { code: "002", name: "Personalised cufflinks", price: 45.00 },
    { code: "003", name: "Kids T-shirt", price: 19.95 }
  ]


  class Checkout

    def initialize
      @checkout_items = []
    end

    def scan(code)
      if existing_item = find_item_by_code(@checkout_items, code)
        existing_item[:qty] += 1
      else
        new_item = find_item_by_code(ITEMS, code)
        new_item[:qty] = 1
        @checkout_items << new_item
      end

      Promotion.apply_item_discount(@checkout_items)
    end

    def grand_total
      Promotion.apply_total_discount(@checkout_items)
    end

    def find_item_by_code(items, code)
      items.find { |i| i[:code] == code }
    end

  end


  class Promotion

    def self.apply_item_discount(checkout_items)
      checkout_items.each do |i|
        if i[:code] == "001" && i[:qty] > 1
          i[:price] = 8.5
        end
      end
      checkout_items
    end

    def self.apply_total_discount(checkout_items)
      sum = checkout_items.inject(0) { |sum, h| sum + (h[:price] * h[:qty]) }
      sum = sum - (sum / 10) if sum > 60
      sum.round 2
    end

  end

end
