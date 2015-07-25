class StaffMember < ActiveRecord::Base
  before_validation do
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def full_name
    self.family_name + " " + self.given_name
  end

  def full_name_kana
    self.family_name_kana + " " + self.given_name_kana
  end
end
