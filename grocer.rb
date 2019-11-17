require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  matching_hash = nil
  while index < collection.length 
    if collection[index][:item] == name
      matching_hash = collection[index]
    end 
  index += 1
end
return matching_hash
end 

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  cart.each do |item|
    if new_cart.include?(item) == false 
      item[:count] = 1
      new_cart << item
    else 
      item[:count]+= 1
    end
  end 
  return new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |each_item|
  coupons.each do |coupon|

      discounted_item = {}
      
      if each_item[:item] == coupon[:item] && each_item[:count] >= coupon[:num]
        discounted_item[:item] = each_item[:item] + " W/COUPON"
        discounted_item[:price] = coupon[:cost] / coupon[:num]
        discounted_item[:count] = coupon[:num]
        discounted_item[:clearance] = each_item[:clearance]

        cart << discounted_item
        each_item[:count] -= coupon[:num]
    end
  end 
end 
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = []
  cart.each do |each_item|
    if each_item[:clearance] == true 
      discounted_item = {}
      discounted_item[:item] = each_item[:item]
      discounted_item[:price] = each_item[:price] - each_item[:price]*(0.2).round(2)
      discounted_item[:clearance] = each_item[:clearance]
      discounted_item[:count] = each_item[:count]
      new_cart << discounted_item
    else 
      new_cart << each_item
  end
end 
return new_cart
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
  p cart
  p coupons
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  newer_cart = apply_clearance(new_cart)
  total = 0 
  newer_cart.each do |each_item|
    total += each_item[:price] * each_item[:count]
  end
  if total >= 100
    total = total - total*(0.1)
  end 
  return total
end
