# spec/requests/admin/users_spec.rb

require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true) }

  describe "GET /admin/users" do
    context "when regular user is logged in" do
      before { sign_in user }

      it "redirects to root_path" do
        get '/admin/users'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when admin user is logged in" do
      before { sign_in admin }

      it "responds with success" do
        get '/admin/users'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /admin/users/:id" do
    context "when admin assigns admin role to a user" do
      before { sign_in admin }

      it "assigns admin role to the user" do
        patch admin_user_path(user), params: { user: { admin: true } }
        user.reload
        expect(user.admin?).to be true
      end
    end

    context "when admin removes admin role from another admin" do
      let(:admin_user) { FactoryBot.create(:user, admin: true) }

      before { sign_in admin }

      it "removes admin role from the user" do
        patch admin_user_path(admin_user), params: { user: { admin: false } }
        admin_user.reload
        expect(admin_user.admin?).to be false
      end
    end

    context "when regular user tries to assign admin role to another regular user" do
      let(:regular_user) { FactoryBot.create(:user) }

      before { sign_in user }

      it "does not assign admin role to the user" do
        patch admin_user_path(regular_user), params: { user: { admin: true } }
        regular_user.reload
        expect(regular_user.admin?).to be false
      end
    end
  end
end
