require 'rails_helper'

RSpec.describe Api::GroupEventsController, type: :controller do

  describe "GET index" do

    it "assigns @group_events" do
      group_events = create_list(:group_event, 10, :published)
      get :index
      expect(assigns(:group_events)).to eq(group_events)
    end

  end

  describe "GET show" do

    it "assigns @group_event" do
      group_event = create(:group_event)
      get :show, params: { id: group_event.id , data: {} }
      expect(assigns(:group_event)).to eq(group_event)
    end

  end

  describe "PATCH update" do

    it "assigns @group_event" do
      group_event = create(:group_event)
      patch :update, params: { id: group_event.id , data: { attributes: {name: "a name"} } }
      expect(assigns(:group_event)).to eq(group_event)
    end

  end

  describe "DELETE destroy" do

    it "assigns @group_event" do
      group_event = create(:group_event)
      delete :destroy, params: { id: group_event.id , data: {} }
      expect(assigns(:group_event)).to eq(group_event)
    end

  end

  describe "POST publish" do

    it "assigns @group_event" do
      group_event = create(:group_event)
      post :publish, params: { id: group_event.id , data: {}}
      expect(assigns(:group_event)).to eq(group_event)
    end

  end


end
