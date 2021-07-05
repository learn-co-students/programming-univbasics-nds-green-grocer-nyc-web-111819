def find_item_by_name_in_collection(name, collection)
  for x in collection do
    if x[:item] == name
      return x
    end
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  newCart = []
  for item in cart do
    item[:count] = 0
  end
  list = []
  for object in cart do
    for object2 in cart[cart.index(object)+1..] do
      if object2[:item] == object[:item]
        object[:count] += 1
      end
    end
    if !list.include? object[:item]
      newCart << object
    end
    list << object[:item]
  end
  for x in newCart do
    if x[:count] == 0
      x[:count] = 1
    end
  end
  newCart
end

def apply_coupons(cart, coupons)
  for coupon in coupons do
    for x in cart.select{|good| good[:item] == coupon[:item]}
      x[:count] += -coupon[:num]
    end
    cart << {:item => coupon[:item]+" W/COUPON", :price => coupon[:cost]/coupon[:num], :clearance => cart.select{|good| good[:item] == coupon[:item]}[0][:clearance], :count => coupon[:num]
  end
  cart
end

def apply_clearance(cart)
  for thing in cart do
    if thing[:clearance] == true
      thing[:price] = thing[:price] - (thing[:price]*0.2).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  newCart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0
  for thing in newCart do
    total = total + thing[:price]*thing[:count]
  end
  if total > 100
    total = total - (total*0.1).round(2)
  end
  total
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
