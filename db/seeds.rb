# rental requests
#
REQUEST_STATUSES = %w(PENDING)

15.times do
  CatRentalRequest.create!(cat_id: rand(1..2), start_date: rand(50..100).days.ago, end_date: rand(1..49).days.ago, status: REQUEST_STATUSES[0], user_id: rand(3..5))
end

15.times do
  CatRentalRequest.create!(cat_id: rand(1..2), start_date: rand(1..49).days.ago, end_date: rand(1..25).days.from_now, status: REQUEST_STATUSES[0], user_id: rand(3..5))
end


## users ##
#has cats
User.create(user_name: 'jeff', password: 'jeffjeff')
User.create(user_name: 'ryan', password: 'ryanryan')
#wants cats
User.create(user_name: 'neff', password: 'neffneff')
User.create(user_name: 'cj', password: 'cjisthebest')
User.create(user_name: 'daniel', password: 'dantheman')
## cats ##

Cat.create(name: Faker::Name.name, color: 'gold', sex: 'F', user_id: 1, birth_date: Faker::Date.backward(1000))
Cat.create(name: Faker::Name.name, color: 'gold', sex: 'F', user_id: 2, birth_date: Faker::Date.backward(1000))

###
