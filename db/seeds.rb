# rental requests
#
REQUEST_STATUSES = %w(PENDING)

15.times do
  CatRentalRequest.create!(cat_id: rand(1..15), start_date: rand(50..100).days.ago, end_date: rand(1..49).days.ago, status: REQUEST_STATUSES[0], user_id: rand(1..2))
end

15.times do
  CatRentalRequest.create!(cat_id: rand(1..15), start_date: rand(1..49).days.ago, end_date: rand(1..25).days.from_now, status: REQUEST_STATUSES[0], user_id: rand(1..2))
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
15.times do
  Cat.create(name: Faker::Name.first_name, color: 'gold', sex: 'F', user_id: rand(1..3), birth_date: Faker::Date.backward(1000))
  end
###
