require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post_obj) { FactoryGirl.create(:post) }

  describe "#new" do
    before {get :new}
    it "renders the new template" do
      expect(response).to render_template(:new)
    end
    it "assigns a post object" do
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      let(:valid_request) {
        post :create, post: FactoryGirl.attributes_for(:post)
      }

      it "saves a record to the database" do
        count_before = Post.count
        valid_request
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end
      it "redirects to the campaign's show page" do
        valid_request
        expect(response).to redirect_to(post_path(Post.last))
      end
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    describe "with invalid attributes" do
      def invalid_request
        post :create, post: {title: ""}
      end
      # before {get :new}
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "sets an alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
      it "doesn't save a record to the database" do
        count_before = Post.count
        invalid_request
        count_after = Post.count
        expect(count_after).to eq(count_before)
      end
    end
  end

  describe "#show" do
    before do
      get :show, id: post_obj.id
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "sets a post instance variable" do
      expect(assigns(:post)).to eq(post_obj)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "assigns an instance variable to all posts in the database" do
      c = FactoryGirl.create(:post)
      c1 = FactoryGirl.create(:post)

      get :index

      expect(assigns(:posts)).to eq([c, c1])
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: post_obj.id
      expect(response).to render_template(:edit)
    end
    it "sets an instance variable with the passed id" do
      get :edit, id: post_obj.id
      expect(assigns(:post)).to eq(post_obj)
    end
  end

  describe "#update" do
    describe "with valid params" do
      let(:new_valid_body) {Faker::ChuckNorris.fact}
      before do
        patch :update, id: post_obj.id, post: {body: new_valid_body}
      end

      it "updates the record whose id was passed" do
        expect(post_obj.reload.body).to eq(new_valid_body)
      end
      it "redirects to the show page" do
        expect(response).to redirect_to(post_path(post_obj))
      end
      it "sets a flash notice message" do
        expect(flash[:notice]).to be
      end
    end
    describe "with invalid params" do
      before do
        patch :update, id: post_obj.id, post: {title: ""}
      end
      it "doesn't update the record who's id was passed" do
        expect(post_obj.title).to eq(post_obj.reload.title)
      end
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end


end
