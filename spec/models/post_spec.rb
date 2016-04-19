require 'rails_helper'

RSpec.describe Post, type: :model do
  # This is nice syntax.. use it with this "expect(post).to_not be_valid"
  let(:post) { Post.new }

  # pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it "requires a title" do
      post.valid?
      expect(post.errors).to have_key :title
    end

    it "requires a body" do
      post.valid?
      expect(post.errors).to have_key :body
    end

    it "requires a title length greater than 7" do
      post.title = "abc"
      post.valid?
      expect(post.errors).to have_key :title
    end

  end

  describe ".body_snippet" do
    it "returns 100 characers with ... if its more than 100 characters" do
      c = Post.new(body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et")
      expect(c.body_snippet).to eq("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore" + "...")
    end

    it "returns the body if the body is less than 100 characters" do
      c = Post.new(body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut")
      expect(c.body_snippet).to eq("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut")
    end
  end
end
