module Admin
  class Base < ApplicationController
    before_action :authorize
    before_action :check_timeout

    private

    def current_administrator
      if session[:administrator_id]
        @current_administrator ||= Administrator.find_by(id: session[:administrator_id])
      end
    end

    def authorize
      unless current_administrator
        flash.alert = '管理者としてログインしてください。'
        redirect_to :admin_login
      end
    end

    TIMEOUT = 60.minutes
    def check_timeout
      if current_administrator
        if session[:last_access_time] >= TIMEOUT.ago
          session[:last_access_time] = Time.current
        else
          session.delete(:administrator_id)
          flash.alert = 'セッションがタイムアウトしました。'
          redirect_to :admin_login
        end
      end
    end

    helper_method :current_administrator
  end
end