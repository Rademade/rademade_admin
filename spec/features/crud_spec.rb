require 'spec_helper'

describe 'CRUD operations', :type => :feature, :js => true do
  let(:admin) { create(:admin_user) }
  let(:headline) { 'test headline' }
  let(:test_text) { 'some text' }

  before(:each) do
    # login
    visit '/rademade_admin'

    fill_in 'data_email', with: admin.email
    fill_in 'data_password', with: admin.password

    first('#data_submit_action button').click
    find('#sidebar-nav')

    # create test item
    visit '/rademade_admin/posts/new'

    fill_in 'data_headline', with: headline
    fill_in 'data_text', with: test_text

    click_on 'Create Post'
  end


  describe 'create entity' do
    it 'should create item' do
      visit '/rademade_admin/posts'

      expect(page).to have_content headline
    end
  end

  describe 'update entity' do
    it 'should update entity' do
      visit '/rademade_admin/posts'
      click_on 'Edit'

      fill_in 'data_headline', with: 'new headline'
      click_on 'Update Post'

      visit '/rademade_admin/posts'

      expect(page).to have_content 'new headline'
    end
  end

  describe 'delete entity' do
    it 'should delete items' do
      visit '/rademade_admin/posts'

      page.evaluate_script('window.confirm = function() { return true; }') # accept confirm

      click_on 'Destroy'
      visit current_path

      expect(page).to_not have_content headline
    end
  end

end