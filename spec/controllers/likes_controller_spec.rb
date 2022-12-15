require "rails_helper"

describe LikesController do

  describe "create action" do
    let(:user) { create(:user) }
    let(:micropost) { create(:micropost) }

    it "update like and count likes if like was given" do
      post :create, params: { micropost_id: micropost.id }, session: { user_id: user.id }

      expect(response).to render_template("create.js.erb")
    end

    it "compares the number of likes after moment where like was given" do
      amount_of_likes_before_request = Like.count
      post :create, params: { micropost_id: micropost.id }, session: { user_id: user.id }
      amount_of_likes_after_request = Like.count

      expect(amount_of_likes_after_request).to eq(amount_of_likes_before_request + 1)
    end
  end
end