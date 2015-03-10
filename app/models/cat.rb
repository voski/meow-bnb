# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :datetime         not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  CAT_COLORS = %w(white black orange purple space_grey gold silver)
  CAT_GENDERS = %w(M F)
  validates :birth_date, :color, :name, presence: true
  validates :sex, inclusion: { in: CAT_GENDERS ,
    message: "%{value} is not a valid gender" }
  validates :color, inclusion: { in: CAT_COLORS,
    message: "%{value} is not a valid color" }

  def age
    Time.now.year - birth_date.year
  end

  def birthday
    return if birth_date.nil?
    "#{birth_date.year}-#{birth_date.month.to_s.rjust(2, '0')}-#{birth_date.day.to_s.rjust(2, '0')}"
  end

  def self.colors
    CAT_COLORS
  end

  def self.genders
    CAT_GENDERS
  end
end
