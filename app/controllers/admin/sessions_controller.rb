class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      admin = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if Admin::Authenticator.new(admin).authenticate(@form.password)
      session[:administrator_id] = admin.id
      flash.notice = 'ログインしました'
      redirect_to :admin_root
    else
      if Admin::Authenticator.new(admin).authenticate(@form.password)
        flash.now.alert = 'アカウントが停止されています'
      else
        flash.now.alert = 'メールアドレスまたはパスワードが違います'
      end
      render 'new'
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'ログアウトしました'
    redirect_to :admin_root
  end
end
