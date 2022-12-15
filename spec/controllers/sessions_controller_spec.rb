require "rails_helper"

describe SessionsController do

  describe "create action" do
    let(:user) { create(:user) }

    it "render user_path if authenticate pass" do
      post :create, params: { session: { email: user.email, password: user.password } }

      expect(response).to redirect_to(user_path(assigns(:user)))
    end

    it "render user_path if authenticate fail" do
      post :create, params: { session: { email: user.email, password: "qwerty"} }

      expect(response).to render_template("new")
    end

    it "return user_id in cookies when is the response" do
      post :create, params: { session: { email: user.email, password: user.password, remember_me: "1" } }

      expect(response.cookies["user_id"]).not_to be_nil
    end
  end

  describe "destroy action" do
    let(:user) { create(:user) }

    it "redirect to home page when is the log out" do
      delete :destroy, params: { id: user.id }, session: { user_id: user.id}

      expect(response).to redirect_to(root_path)
    end

    it "notification is there if an user is the log out" do
      delete :destroy, params: { id: user.id }, session: { user_id: user.id}

      expect(flash[:notice]).to eq("Вы вышли из аккаунта")
    end

    it "return nil in session when is the log out" do
      delete :destroy, params: { id: user.id }, session: { user_id: user.id}

      expect(session[:user]).to be_nil
    end
  end

end