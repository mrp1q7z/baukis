class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
        !@staff_member.suspended? &&
        @staff_member.hashed_password &&
        @staff_member.start_date < Date.today &&
        (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
        BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end

  def is_supended(raw_password)
    auth = @staff_member &&
        @staff_member.hashed_password &&
        @staff_member.start_date < Date.today &&
        (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
        BCrypt::Password.new(@staff_member.hashed_password) == raw_password
    auth && @staff_member.suspended
  end
end