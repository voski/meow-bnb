REQUEST_STATUSES = %w(PENDING)

20.times do
  CatRentalRequest.create!(cat_id: rand(1..2), start_date: rand(50..100).days.ago, end_date: rand(1..49).days.ago, status: REQUEST_STATUSES[0])
end

10.times do
  CatRentalRequest.create!(cat_id: rand(1..2), start_date: rand(1..49).days.ago, end_date: rand(1..25).days.from_now, status: REQUEST_STATUSES[0])
end
