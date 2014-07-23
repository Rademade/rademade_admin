# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Menu', :type => :feature, :js => true do

  let(:admin) do
    create :admin_user, :password => '12345678'
  end

  before(:each) do
    # login
    visit '/rademade_admin'

    fill_in 'data_email', with: admin.email
    fill_in 'data_password', with: '12345678'

    first('#data_submit_action button').click
    find('#sidebar-nav')
  end

  it 'should have "dashboard" item' do
    expect(page).to have_content 'Home'
  end

  it 'should have root models' do
    expect(page).to have_content 'User'
    expect(page).to have_content 'Post'
  end

  it 'should show inner menu items on click' do
    click_on('Post')
    expect(page).to have_content 'Post'
    expect(page).to have_content 'Tag'
  end

end
