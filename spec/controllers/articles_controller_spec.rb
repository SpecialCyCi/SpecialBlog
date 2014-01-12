# coding: utf-8
require 'spec_helper'
describe ArticlesController do

  let(:valid_attributes) { { "title" => "MyString", "content" => "abc" } }
  let(:valid_session) { {} }
  let(:categories) { FactoryGirl.create_list :category, 10 }
  let(:articles) { FactoryGirl.create_list :article, 5, category: categories.first }

  describe "GET index" do

    it "assigns all articles as @articles" do
      articles
      get :index, {}, valid_session
      assigns(:articles).should eq(articles.last(5))
    end

    it "assigns category' articles" do
      # call let后函数才被用
      categories; articles
      FactoryGirl.create_list :article, 5, category: categories.last
      get :index, { category: categories.first }
      assigns(:articles).should eq categories.first.articles.all 
    end
  end

  describe "GET show" do
    it "assigns the requested article as @article" do
      article = Article.create! valid_attributes.merge(category: categories.first.id)
      get :show, {:id => article.to_param}, valid_session
      assigns(:article).should eq(article)
    end
  end

end
