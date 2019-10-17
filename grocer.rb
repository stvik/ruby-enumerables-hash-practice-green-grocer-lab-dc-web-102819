def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.map do |group|
    group.each do |item, value|
    if new_cart[item]
      new_cart[item][:count] += 1
    else
      new_cart[item] = value
      new_cart[item][:count] = 1
    end
   end
  end
  new_cart
end
  

def apply_coupons(cart, coupons)
  # code here
  coupon_cart = cart
  coupons.each do |coupon|
    product = coupon[:item]
    num_c = coupon[:num]*coupons.count(coupon)
    new_name = "#{product} W/COUPON"
      if  cart.include?(product) && num_c <= cart[product][:count]
        coupon_cart[new_name] = {price: coupon[:cost]/coupon[:num], clearance: cart[product][:clearance], count: num_c}
        coupon_cart[product][:count] -= num_c
      end
    end
  coupon_cart
end

def apply_clearance(cart)
  # code here
  new_cart = cart
  cart.each do |item,value|
    if value[:clearance]
      new_cart[item][:price] = (value[:price] * 0.80).round(2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  # code here
  final_cart = consolidate_cart(cart)
  apply_coupons(final_cart,coupons)
  apply_clearance(final_cart)
  total = 0
  final_cart.each do |item, value|
    total += value[:price]*value[:count]
  end
  if total > 100
    total = total * 0.90
  end
  total.round(2)  
end
