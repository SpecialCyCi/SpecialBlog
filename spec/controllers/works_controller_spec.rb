require 'spec_helper'

describe WorksController do
  
  let(:valid_attributes) { { "name" => "MyString", "description" => "asdasd" } }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all works as @works" do
      work = Work.create! valid_attributes
      get :index, {}, valid_session
      assigns(:works).should eq([work])
    end
  end

  describe "GET show" do
    it "assigns the requested work as @work" do
      work = Work.create! valid_attributes
      get :show, {:id => work.to_param}, valid_session
      assigns(:work).should eq(work)
    end
  end
end
