require 'rails_helper'

describe UsersController do

  # def self.it_renders_404_page_when_user_is_not_found(*actions)
  #   actions.each do |a|
  #     it "#{a} renders 404 page when user is not found" do
  #       verb = if a == :update
  #                "PATCH"
  #              elsif a == :destroy
  #                "DELETE"
  #              else
  #                "GET"
  #              end
  #       process a, verb, params { id: 0 }
  #
  #       expect(response).to have_http_status(404)
  #     end
  #   end
  # end

  # it_renders_404_page_when_user_is_not_found :show, :edit, :update, :destroy
  describe "show action" do

    it "renders show template if an user is found" do
      user = create(:user)
      get :show, params: { id: user.id }

      expect(response).to render_template("show")
    end

    it "renders 404 page if an user is not found" do
      get :show, params: { id: 0 }

      expect(response).to have_http_status(404)
    end
  end

  describe "create action" do

    it "redirect to user_path if validations pass" do
      post :create, params: { user: { name: "Mikhail", email: "mikhail@email.com",
                                      password: "123456", password_confirmation: "123456" }
                            }

      expect(response).to redirect_to(user_path(assigns(:user)))
    end

    it "render new page if validations fail" do
      post :create, params: { user: { name: "Mikhail", email: "mikhail@email.com",
                                     password: "123456", password_confirmation: "foobar" }
      }

      expect(response).to render_template("new")
    end
  end

  describe "destroy action" do
    let!(:user) { create(:user) }
    let!(:current_user) { create(:user) }
    let(:amount_of_users_before_request) { User.count}
    let(:amount_of_users_after_request) { User.count}
    before do
      delete :destroy, params: { id: user.id }, session: { user_id: current_user.id}
    end

    it "redirect to users_path if user is not deleted" do
      expect(response).to redirect_to(users_path)
    end

    it "notification is missing if user is not deleted" do
      expect(flash[:notice]).to be_nil
    end

    it "amount of users has not changed if user is not deleted" do
      amount_of_users_before_request

      expect(amount_of_users_after_request).to eq(amount_of_users_before_request)
    end

    it "renders 404 page if user is not found" do
      delete :destroy, params: { id: 0, user: {admin: 1} }

      expect(response).to have_http_status(404)
    end
  end

  describe "update action" do
    let!(:user) { create(:user)}
    let(:other_user) { create(:user)}
    let(:correct_user) { { name: "Mikhail", email: "mikhail@email.com",
                           password: "123456", password_confirmation: "123456"} }
    let(:incorrect_user) { { name: "Mikhail", email: "mikhail@email.com",
                             password: "123456", password_confirmation: "foobar"} }

    it "renders edit template if an user hasn't been changed" do
      patch :update, params: { id: user.id, user: incorrect_user },
                                    session: { user_id: user.id }

      expect(response).to render_template("edit")
    end

    it "redirect to show template if an user has been changed" do
      patch :update, params: { id: user.id, user: correct_user },
                                    session: { user_id: user.id }

      expect(response).to redirect_to(user_path(assigns(:user)))
    end

    it "notification is there if an user has been changed" do
      patch :update, params: { id: user.id, user: correct_user },
                                    session: { user_id: user.id }

      expect(flash[:notice]).to eq("Аккаунт изменен")
    end

    it "redirect to home template if other user try change" do
      patch :update, params: { id: user.id, user: correct_user },
                                    session: { user_id: other_user.id }

      expect(response).to render_template("/")
    end

    it "return 403 error if other user try change" do
      patch :update, params: { id: user.id, user: correct_user },
                                    session: { user_id: other_user.id }

      expect(response).to have_http_status(403)
    end
  end

  describe "index action" do

    it "redirect to home template if unauthorized user try render index page" do
      get :index

      expect(response).to have_http_status(401)
    end
  end
end