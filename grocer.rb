 def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.count do
    name == collection[i][:item] ? hash = collection[i] : nil
    i += 1
  end
  hash
end

def find_item_by_name_in_collection_l(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.count do
    name == collection[i][:item] ? hash = i : nil
    i += 1
  end
  hash
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  array = []
  i = 0
  while i < cart.count do
    name = cart[i][:item]
    exists = find_item_by_name_in_collection(name, array)
    l = find_item_by_name_in_collection_l(name, array)
    if exists
      array[l][:count] += 1
    else
      array << cart[i]
      array[-1][:count] = 1
    end
    i += 1
  end
  array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < coupons.count do
    name = coupons[i][:item]
    exists = find_item_by_name_in_collection(name, cart)
    l = find_item_by_name_in_collection_l(name, cart)
    hold = []
    if exists && cart[l][:count] >= coupons[i][:num]
      new_name = "#{coupons[i][:item]} W/COUPON"
      cart << {
        item: new_name,
        count: coupons[i][:num],
        price: coupons[i][:cost] / coupons[i][:num],
        clearance: cart[l][:clearance]
      }
      cart[l][:count] -= coupons[i][:num]
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.count do
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - 0.2 * cart[i][:price]).round(2)
    end
    i += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  grand_total = 0
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)
  i = 0
  while i < new_cart.count do
      grand_total += new_cart[i][:price] * new_cart[i][:count]
      i += 1
  end
  if grand_total > 100
    grand_total = (grand_total - 0.1 * grand_total).round(2)
  end
  grand_total
end
