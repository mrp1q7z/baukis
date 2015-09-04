class StaffMember < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}]+\z/

  validates :start_date, presence: true, date: {
                after_or_equal_to: Date.new(2000, 1, 1),
                before: -> (obj) { 1.year.from_now.to_date },
                allow_blank: true
                }
  validates :end_date, date: {
                after: :start_date,
                before: -> (obj) { 1.year.from_now.to_date },
                allow_blank: true
                }

  def full_name
    self.family_name + " " + self.given_name
  end

  def full_name_kana
    self.family_name_kana + " " + self.given_name_kana
  end

  def active?
    !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today)
  end
end
