require 'pry'
def find_item_by_name_in_collection(name, collection)
  collection.each do |grocery_hash|
    if grocery_hash[:item] == name
      return grocery_hash
    end
  end
  return nil 
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  new_array = []
  cart.each do |grocery_hash|
    if find_item_by_name_in_collection(grocery_hash[:item], new_array)
      # new_hash[:item] = grocery_hash[:item]
      # new_hash[:price] = grocery_hash[:price]
      # new_hash[:clearance] = grocery_hash[:clearance]
   grocery_hash[:count] += 1 
  else 
    grocery_hash[:count] = 1 
  new_array  << grocery_hash
  end 
end
return new_array
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  new_array = []
  if coupons.length != 0
  cart.each do |grocery_hash|
    coupons.each do |coupon_hash|
      if grocery_hash[:item] == coupon_hash[:item] && grocery_hash[:count] >= coupon_hash[:num]
        grocery_hash[:count] -= coupon_hash[:num]
        new_hash = {
        :item => grocery_hash[:item] + " W/COUPON",
        :price => coupon_hash[:cost]/coupon_hash[:num],
        :count => coupon_hash[:num], 
        :clearance => grocery_hash[:clearance]
        }
        new_array << new_hash
        new_array << grocery_hash
      elsif !new_array.include?(grocery_hash)
        new_array << grocery_hash
end 
    end
  end
return new_array
else 
  return cart 
end 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  cart.each do |item_hash|
    if item_hash[:clearance] == true 
     item_hash[:price] -= (item_hash[:price] * 0.20)
    end 
  end
return cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  float = 0 
  new_cart = consolidate_cart(cart) 
  new_cart_2 = apply_coupons(new_cart, coupons)
  apply_clearance(new_cart_2)
    new_cart_2.each do |grocery_hash|
float += (grocery_hash[:price] * grocery_hash[:count])
    end 
if float > 100 
  float -= (float * 0.10)
end
return float
    
    
    
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
