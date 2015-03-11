# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :datetime         not null
#  end_date   :datetime         not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat

  REQUEST_STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: {
    in: REQUEST_STATUSES,
    message: '"%{value}" NOT A VALID STATUS'
  }

  def overlapping_requests
    potential_conflicts = CatRentalRequest.all.where.not(id: self.id).where(cat_id: self.cat_id)

    potential_conflicts.select do |conflict|
      self.overlaps?(conflict)
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select do |request|
      request.status == 'APPROVED'
    end
  end

  def overlaps?(other_request)
    (start_date - other_request.end_date) * (other_request.start_date - end_date) >= 0
  end
end
