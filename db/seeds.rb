REQUEST_STATUSES = %w(PENDING APPROVED DENIED)

50.times do
  CatRentalRequest.create!(cat_id: rand(1..5), start_date: rand(50..100).days.ago, end_date: rand(1..49).days.ago, status: REQUEST_STATUSES[rand(3)])
end

50.times do
  CatRentalRequest.create!(cat_id: rand(1..5), start_date: rand(1..49).days.ago, end_date: rand(1..25).days.from_now, status: REQUEST_STATUSES[rand(3)])  
end
