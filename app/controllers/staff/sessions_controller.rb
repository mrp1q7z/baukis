class Staff::SessionsController < Staff::Base
  skip_before_action :authorize

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      flash.notice = 'ログインしました'
      redirect_to :staff_root
    else
      if Staff::Authenticator.new(staff_member).is_supended(@form.password)
        flash.now.alert = 'アカウントが停止されています'
      else
        flash.now.alert = 'メールアドレスまたはパスワードが違います'
      end
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました'
    redirect_to :staff_root
  end
end
