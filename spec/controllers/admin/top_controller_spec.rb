require 'rails_helper'

describe Admin::TopController do
  context 'ログイン後' do
    let(:admin_member) { create(:administrator) }

    before do
      session[:administrator_id] = admin_member.id
      session[:last_access_time] = 1.second.ago
    end

    describe '#index' do
      example 'セッションタイムアウト' do
        session[:last_access_time] = Admin::Base::TIMEOUT.ago.advance(seconds: -1)
        get :index
        expect(session[:administrator_id]).to be_nil
        expect(response).to redirect_to(admin_login_url)
      end
    end
  end
end