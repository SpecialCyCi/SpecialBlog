# encoding: utf-8
require 'spec_helper'

describe CommentsController do

  let(:valid_attributes) { { "nickname" => "MyString", "content" => "comments"  } }
  let(:valid_session) { {} }
  let(:article) { Article.first }

  # 每一个测试用例都会执行这里
  before do
    # 创建10篇文章
    FactoryGirl.create_list :article, 10
  end

  describe "GET index" do

    before do
      comments = FactoryGirl.create_list :comment, 10 
      article.comments = comments
      article.save
      # 干扰项
      FactoryGirl.create_list :comment, 10
    end

    it "should get corresponding article's comments" do
      get :index, article_id: article.id
      assigns(:comments).should eq article.comments
    end
    
  end

  describe "POST create" do
   
    it "should create a comment on corresponding article" do
      # 期望{}里代码使 Comment.count + 1
      expect{
        # 向 article/1/comment/create 这个地址Post
        post :create, article_id: article.id, comment:  valid_attributes  
      }.to change(Comment, :count).by(1)
      # 检测是不是发到对应的文章去了
      article.comments.count.should eq 1
      article.comments.first.nickname.should eq valid_attributes["nickname"]
    end

    it "should not create a comment if content is nil" do
      valid_attributes["content"] = ""
      expect{
        post :create, article_id: article.id, comment: valid_attributes
      }.to change(Comment, :count).by(0)
    end
    
  end
end
