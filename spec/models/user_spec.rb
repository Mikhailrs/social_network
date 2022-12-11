require 'rails_helper'

describe User do

  it "return an error when email not correct" do
    user = User.create(name: "Mikhail", email: "123456", password: "foobar")
    expect(user.errors.full_messages.first).to eq("Email is invalid")
  end
end