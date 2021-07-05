def find_item_by_name_in_collection(name, collection)
    index = 0 
    output = nil
  while index < collection.length do
    if (collection[index][:item] == name) 
      output=collection[index]
    end
    index= index + 1 
  end
  return output
end


def consolidate_cart(cart)
 new_cart = []
 cart.each do |item|
   new_cart_item = find_item_by_name_in_collection(item[:item], new_cart)
   if new_cart_item
     new_cart_item[:count] += 1
   else
     new_cart_item = {
       :item => item[:item],
       :price => item[:price],
       :clearance => item[:clearance],
       :count => 1
     }
     new_cart.push(new_cart_item)
   end
 end
 new_cart
end


def apply_coupons(cart, coupons)
  new_cart = cart
  cart.length.times { |i|
    coupons.length.times { |j|
      if cart[i][:item] == coupons[j][:item] && coupons[j][:num] <= cart[i][:count]
        new_cart[i][:count] -= coupons[j][:num]
        new_cart.append({
          :item => "#{cart[i][:item]} W/COUPON",
          :price => (coupons[j][:cost])/(coupons[j][:num]),
          :clearance => cart[i][:clearance],
          :count => coupons[j][:num]
        })
      end
    }
  }
  new_cart
end  


def apply_clearance(cart)
  cart.length.times {|i|
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price]*0.8).round(2)
    end
  }
  cart
end

def checkout(cart, coupons)
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  cart.length.times {|i|
    total += cart[i][:price]*cart[i][:count]
  }
  if total > 100
    total *= 0.9
  end
  total
end 