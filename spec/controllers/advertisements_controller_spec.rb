require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let (:my_advertisement) { Advertisement.create!(title: "New Advert Title", copy: "New Advert Copy", price: 5) }


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_advertisement] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([my_advertisement])
    end

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: my_advertisement.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { id: my_advertisement.id }
      expect(response).to render_template :show
    end

    it "assigns my_advertisement to @advertisement" do
      get :show, params: { id: my_advertisement.id }
      expect(assigns(:advertisement)).to eq(my_advertisement)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end


  describe "POST create" do
    it "increases the number of Advertisement by 1" do
      expect{ post :create, params: { advertisement: { title: "New Ad Title", copy: "New Ad Copy", price: 5 } } }.to change(Advertisement,:count).by(1)
    end

    it "assigns the new advertisement to @advertisement" do
      post :create, params: { advertisement: { title: "New Ad Title", copy: "New Ad Copy", price: 5 } }
      expect(assigns(:advertisement)).to eq Advertisement.last
    end

    it "redirects to the new Advertisement" do
      post :create, params: { advertisement: { title: "New Ad Title", copy: "New Ad Copy", price: 5 } }
      expect(response).to redirect_to Advertisement.last
    end
  end

end

#
#     it "assigns my_post to @post" do
#       get :show, params: { id: my_post.id }
#       expect(assigns(:post)).to eq(my_post)
#     end
#   end
#
#   describe "GET new" do
#     it "returns http success" do
#       get :new
#       expect(response).to have_http_status(:success)
#     end
#
#     it "renders the #new view" do
#       get :new
#       expect(response).to render_template :new
#     end
#
#     it "instantiates @post" do
#       get :new
#       expect(assigns(:post)).not_to be_nil
#     end
#   end
#
#   describe "POST create" do
#     it "increases the number of Post by 1" do
#       expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
#     end
#
#     it "assigns the new post to @post" do
#       post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
#       expect(assigns(:post)).to eq Post.last
#     end
#
#     it "redirects to the new post" do
#       post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
#       expect(response).to redirect_to Post.last
#     end
#   end
#
# end
