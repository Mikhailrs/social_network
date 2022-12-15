require "rails_helper"

describe MicropostsController do

  describe "create action" do
    let(:user) { create(:user) }
    let(:micropost) { build(:micropost) }

    it "redirect to show page when micropost was created" do
      post :create, params: { user_id: user.id, microposts: micropost.attributes }, session: { user_id: user.id }

      expect(response).to redirect_to(user_path(assigns(:user)))
    end

    it "return 401 error if unauthorized user try create post" do
      post :create, params: { user_id: user.id, microposts: micropost.attributes }

      expect(response).to have_http_status(401)
    end

    it "render home template if unauthorized user try create post" do
      post :create, params: { user_id: user.id, microposts: micropost.attributes }

      expect(response).to render_template("/")
    end
  end

  describe "destroy action" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:micropost) { create(:micropost) }

    it "redirect to show page when micropost was deleted" do
      delete :destroy, params: { user_id: user.id, id: micropost.id }, session: { user_id: user.id }

      expect(response).to redirect_to(user_path(assigns(:user)))
    end

    it "return 401 error if unauthorized user try delete post" do
      delete :destroy, params: { user_id: user.id, id: micropost.id }

      expect(response).to have_http_status(401)
    end

    it "render home template if unauthorized user try delete post" do
      delete :destroy, params: { user_id: user.id, id: micropost.id }

      expect(response).to render_template("/")
    end

    it "return 403 error if user try delete stranger post from someone else's page" do
      delete :destroy, params: { user_id: user.id, id: micropost.id }, session: { user_id: other_user.id }

      expect(response).to have_http_status(403)
    end
  end
end