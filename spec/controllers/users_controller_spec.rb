require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:topic) { create(:topic) }

  let (:new_user_attributes) do
    { name: "TheoDeane", email: "theo@meowmeow.com", password: "meowmeow", password_confirmation: "meowmeow" }
  end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "instantiates a new user" do
        get :new
        expect(assigns(:user)).to_not be_nil
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

       it "renders the #show view" do
         get :show, params: { id: user.id }
         expect(response).to render_template :show
       end

       it "returns the users posts" do
         get :show, params: { id: user.id }
         user.posts.create!(title: "testingtitle", body: "Testing the body of a post", topic: topic)
         expect(user.posts.count).to eq(1)
         expect(user.posts.last.user_id).to eq(user.id)
       end

       it "returns the users comments" do
         get :show, params: { id: user.id }
         user.comments.create!(body: "Testing comment body", post: post)
         user.comments.create!(body: "Testing comment body again", post: post)
         expect(user.comments.count).to eq(2)
         expect(user.comments.last.user_id).to eq(user.id)
       end

       it "returns the users favorites" do
         get :show, params: { id: user.id }
         user.favorites.create!(user: user, post: post)
         user.favorites.create!(user: user, post: post)
         expect(user.favorites.count).to eq(2)
         expect(user.favorites.last.user_id).to eq(user.id)
       end

    end

    describe "POST create" do
      it "returns an http redirect" do
        post :create, params: { user: new_user_attributes }
        expect(response).to have_http_status(:redirect)
      end

      it "creates a new user" do
        expect { post :create, params: { user: new_user_attributes } }.to change(User, :count).by(1)
      end

      it "sets user name properly" do
        post :create, params: { user: new_user_attributes }
        expect(assigns(:user).name).to eq new_user_attributes[:name]
      end

      it "sets user email properly" do
        post :create, params: { user: new_user_attributes }
        expect(assigns(:user).email).to eq new_user_attributes[:email]
      end

      it "sets user password properly" do
        post :create, params: { user: new_user_attributes }
        expect(assigns(:user).password).to eq new_user_attributes[:password]
      end

      it "sets user password_confirmation properly" do
        post :create, params: { user: new_user_attributes }
        expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
      end

      it "logs the user in after signing up" do
        post :create, params: { user: new_user_attributes }
        expect(session[:user_id]).to eq assigns(:user).id
      end
    end

    describe "not signed in" do
      let(:factory_user) { create(:user) }

      before do
        post :create, params: { user: new_user_attributes }
      end

      it "returns http success" do
        get :show, params: { id: factory_user.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: factory_user.id }
        expect(response).to render_template :show
      end

      it "assigns factory_user to @user" do
        get :show, params: { id: factory_user.id }
        expect(assigns(:user)).to eq(factory_user)
      end
    end

end
