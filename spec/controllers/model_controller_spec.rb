# -*- encoding : utf-8 -*-
require 'spec_helper'

describe RademadeAdmin::PostsController, :js => true do
  render_views

  let(:admin) do
    create :admin_user, :password => '12345678'
  end

  before(:each) do
    # login
    visit rademade_admin_path

    fill_in 'data_email', with: admin.email
    fill_in 'data_password', with: '12345678'

    first('#data_submit_action button').click
    find('#sidebar-nav')
  end

  describe 'GET index' do

    before(:each) do
      visit rademade_admin_posts_path
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
      visit new_rademade_admin_post_path
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should render right template' do
      expect(response).to render_template('rademade_admin/abstract/new')
    end

  end

  describe 'POST create' do

    before(:each) do
      visit new_rademade_admin_post_path
      fill_in 'data_headline', with: 'test headline'
      fill_in 'data_text', with: 'some text'
      click_on 'Create'
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successful' do
      expect(find('.notifier')).to have_content('was inserted!')
    end

    it 'should save without errors' do
      expect(find('.notifier')).to_not have_content('Error occurred')
    end

  end

  describe 'PUT update' do

    before(:each) do
      post = create :post
      visit edit_rademade_admin_post_path(:id => post.id)
      fill_in 'data_headline', with: 'new headline'
      fill_in 'data_text', with: 'new text'
      click_on 'Save changes'
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should be successful' do
      expect(find('.notifier')).to have_content('was updated!')
    end

    it 'should update' do
      find('.notifier')
      visit rademade_admin_posts_path
      expect(page).to have_content 'new headline'
    end

  end

  describe 'DELETE destroy' do

    before(:each) do
      post = create :post, headline: 'post to remove'
      visit rademade_admin_posts_path
      page.evaluate_script('window.confirm = function() { return true; }') # accept confirm
      click_on 'Destroy'
      find('.notifier')
      visit current_path
    end

    it 'should be successful' do
      expect(page).not_to have_content('post to remove')
    end

  end

  describe 'GET edit' do

    before(:each) do
      post = create :post, headline: 'test headline'
      visit edit_rademade_admin_post_path(:id => post.id)
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should find record' do
      expect(page).to have_content 'test headline'
    end

    it 'should render right template' do
      expect(response).to render_template('rademade_admin/abstract/edit')
    end

  end

  describe 'GET autocomplete' do

    before(:each) do
      post = create :post, headline: 'test headline'
      visit autocomplete_rademade_admin_posts_path(:q => 'test')
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should return some record' do
      expect(page).to have_content('id')
    end

  end

  #describe 'PATCH re_sort' do
  #
  #  before(:each) do
  #    first_post = create :post, headline: 'first'
  #    second_post = create :post, headline: 'second'
  #    patch :re_sort, sorted: { '0' => [first_post.id, '1'], '1' => [second_post.id, '0'] }, minimum: 0
  #  end
  #
  #  it 'should have status 200' do
  #    expect(response.status).to eq(200)
  #  end
  #
  #  it 'should sort' do
  #    post = Post.find_by(headline: 'first')
  #    expect(post.position).to eq(1)
  #  end
  #
  #end

  describe 'GET form' do

    it 'should render right template' do
      visit form_new_rademade_admin_post_path
      expect(response).to render_template('rademade_admin/abstract/_form')
    end

    it 'should show form for existing item' do
      post = create :post, :text => 'some text'
      visit form_rademade_admin_post_path(:id => post.id)
      expect(page).to have_field('Text', with: 'some text')
    end

  end

  describe 'PATCH unlink_relation' do

    before(:each) do
      user = create :simple_user
      post = create :post, headline: 'first', user: user
      visit edit_rademade_admin_user_path(:id => user.id)
      click_on 'Delete'
    end

    it 'should have status 200' do
      expect(page).not_to have_content('first')
    end

  end

  describe 'PUT link_relation' do

    before(:each) do
      user = create :simple_user
      visit edit_rademade_admin_user_path(:id => user.id)
      post = create :post, headline: 'first'
      find('.select2-input').click
      find('.select2-result-label').click
    end

    it 'should be successful' do
      expect(page).to have_content('first')
    end

  end

  describe 'GET show' do

    before(:each) do
      post = create :post, text: 'some text'
      visit rademade_admin_post_path(:id => post.id, :format => :json)
    end

    it 'should have status 200' do
      expect(response.status).to eq(200)
    end

    it 'should show item' do
      expect(page).to have_content('some text')
    end

  end

end
