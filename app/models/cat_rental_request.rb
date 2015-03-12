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
#  user_id    :integer          default("0"), not null
#

class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat
  belongs_to :user

  REQUEST_STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :user_id , presence: true
  validate :request_does_not_overlap
  validates :status, inclusion: {
    in: REQUEST_STATUSES,
    message: '"%{value}" NOT A VALID STATUS'
  }

  def request_does_not_overlap

    unless status == 'DENIED' || overlapping_approved_requests.empty?
      errors.add(:cat_id,  "is already booked")
    end
  end

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

  def pending?
    self.status == 'PENDING'
  end

  def approve!
    if overlapping_approved_requests.empty?
      self.class.transaction do
        self.status = 'APPROVED'
        self.save!
        overlapping_requests.each do |request|
          request.deny!
        end
      end
    else
      flash.now[:error] = "Status cannot be approved due to conflictin approvals"
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end
end
