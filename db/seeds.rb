# 10.times do
#   MenuItem.create(
#     name: Faker::Food.dish,
#     price: rand(10..50) * 100
#   )
# end

MenuItem.create(name: 'Prince Polo', price: 199, menu_category: 'food', image_url: 'https://i.imgur.com/l4tEqmL.png')
MenuItem.create(name: 'Donut Chocolate', price: 129, menu_category: 'food', image_url: 'https://i.imgur.com/LRwEakM.png')
MenuItem.create(name: 'Donut limited', price: 159, menu_category: 'food', image_url: 'https://i.imgur.com/3sgNWeJ.png')
MenuItem.create(name: 'Banana', price: 99, menu_category: 'food', image_url: 'https://i.imgur.com/eUzrUjG.png')
MenuItem.create(name: 'Monster classic', price: 599, menu_category: 'drinks', image_url: 'https://i.imgur.com/WEDXcDi.png')
MenuItem.create(name: 'Monster juiced', price: 599, menu_category: 'drinks', image_url: 'https://i.imgur.com/QNLaQ9L.png')
MenuItem.create(name: 'Mullermilch CoCo', price: 499, menu_category: 'drinks', image_url: 'https://i.imgur.com/OGLkpV5.png')
MenuItem.create(name: 'Mullermilch Chocolate', price: 499, menu_category: 'drinks', image_url: 'https://i.imgur.com/fCHrRRT.png')
MenuItem.create(name: 'Mullermilch Strawberry', price: 499, menu_category: 'drinks', image_url: 'https://i.imgur.com/0HICucM.png')
