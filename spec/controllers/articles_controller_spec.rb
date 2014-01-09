require 'spec_helper'
describe ArticlesController do

  let(:valid_attributes) { { "title" => "MyString" } }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all articles as @articles" do
      article = Article.create! valid_attributes
      get :index, {}, valid_session
      assigns(:articles).should eq([article])
    end
  end

  describe "GET show" do
    it "assigns the requested article as @article" do
      article = Article.create! valid_attributes
      get :show, {:id => article.to_param}, valid_session
      assigns(:article).should eq(article)
    end
  end

end
