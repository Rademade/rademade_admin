require 'spec_helper'

describe RademadeAdmin::PostsController do

  self.controller_class = RademadeAdmin::PostsController
  render_views

  before do
    sign_in FactoryGirl.create(:admin_user)
  end

  describe 'GET index' do

    before(:each) do
      get :index
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should render right template' do
      expect(response).to render_template('rademade_admin/abstract/index')
    end

  end

  describe 'GET new' do

    before(:each) do
      get :new
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should create new unsaved item' do
      expect(assigns(:item)).to be_new_record
    end

    it 'should render right tamplate' do
      expect(response).to render_template('rademade_admin/abstract/new')
    end

  end

  describe 'POST create' do

    before(:each) do
      post :create, data: { headline: 'test headline', text: 'some text' }
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successfull' do
      expect(response.body).to include('was inserted!')
    end

    it 'should save without errors' do
      expect(assigns(:item)).to_not be_new_record
    end

  end

  describe 'PUT update' do

    before(:each) do
      post :create, data: { headline: 'test headline', text: 'some text' }
      id = assigns(:item).id

      put :update, id: id, data: { headline: 'new headline', text: 'new text' }
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successfull' do
      expect(response.body).to include('was updated!')
    end

    it 'should update' do
      updated = assigns(:item)

      expect(updated.headline).to eq('new headline')
      expect(updated.text).to eq('new text')
    end

  end

  describe 'DELETE destroy' do

    before(:each) do
      post :create, data: { headline: 'test headline', text: 'some text' }
      id = assigns(:item).id

      delete :destroy, id: id
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successfull' do
      expect(response.body).to include('was deleted!')
    end

    it 'should delete' do
      expect(assigns(:item)).to be_deleted
    end

  end

  describe 'GET edit' do

    before(:each) do
      post :create, data: { headline: 'test headline', text: 'some text' }
      id = assigns(:item).id

      get :edit, id: id
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should find record' do
      expect(assigns(:item)).to_not be_nil
    end

    it 'should render right template' do
      expect(response).to render_template('rademade_admin/abstract/edit')
    end

  end

  describe 'GET autocomplete' do

    before(:each) do
      post :create, data: { headline: 'test headline', text: 'some text' }
      get :autocomplete, q: 'test'
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should return some record' do
      expect(response.body).to include('id')
    end

  end

  describe 'PATCH re_sort' do

    before(:each) do
      post :create, data: { headline: 'first', text: 'first' }
      first_id = assigns(:item).id
      post :create, data: { headline: 'second', text: 'second' }
      second_id = assigns(:item).id

      patch :re_sort, sorted: { '0' => [first_id, '1'], '1' => [second_id, '0'] }, minimum: 0
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should sort' do
      post = Post.find_by(headline: 'first')
      expect(post.position).to eq(1)
    end

    it 'should be "ok"' do
      expect(response.body).to include('ok')
    end

  end

  describe 'GET form' do

    it 'should render right template' do
      get :form

      expect(response).to render_template('rademade_admin/abstract/_form')
    end

    it 'should show form for existing item' do
      post :create, data: { headline: 'first', text: 'some text' }
      id = assigns(:item).id

      get :form, id: id

      expect(response.body).to include('some text')
    end

  end

  describe 'PATCH unlink_relation' do

    before(:each) do
      user = create :simple_user, email: 'l@r.t', first_name: 'first', last_name: 'second', password: '12345678'

      post :create, data: { headline: 'first', text: 'first' }
      post_id = assigns(:item).id

      put :link_relation, parent_id: user.id.to_s, parent: 'User', id: post_id.to_s

      patch :unlink_relation, parent_id: user.id.to_s, parent: 'User', id: post_id.to_s
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successful' do
      expect(response.body).to include('was unlinked from entity!')
    end

    it 'should link' do
      user = User.first

      expect(user.posts).to eq([])
    end

  end

  describe 'PUT link_relation' do

    before(:each) do
      user = create :simple_user, email: 'l@r.t', first_name: 'first', last_name: 'second', password: '12345678'

      post :create, data: { headline: 'first', text: 'first' }
      post_id = assigns(:item).id

      put :link_relation, parent_id: user.id.to_s, parent: 'User', id: post_id.to_s
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successfull' do
      expect(response.body).to include('was linked to entity!')
    end

    it 'should link' do
      post = Post.first

      expect(post.user).to_not be_nil
    end

  end

  describe 'GET show' do

    before(:each) do
      post :create, data: { headline: 'some headline', text: 'some text' }
      id = assigns(:item).id

      get :show, id: id, format: 'json'
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should show item' do
      expect(response.body).to include('some text')
    end

  end

end