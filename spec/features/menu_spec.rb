# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Menu', :type => :feature, :js => true do

  let(:admin) do
    create :admin_user, :password => '12345678'
  end

  before(:each) do
    # login
    visit rademade_admin_path

    fill_in 'data_email', :with => admin.email
    fill_in 'data_password', :with => '12345678'

    click_on 'Log in'
    find('#wrapper')
  end

  it 'should have "dashboard" item' do
    expect(page).to have_content 'Home'
  end

  it 'should have root models' do
    expect(page).to have_content 'Categories'
    expect(page).to have_content 'Items'
    expect(page).to have_content 'Colors'
  end

  it 'should show inner menu items on click' do
    click_on('Active record')
    expect(page).to have_content 'Authors'
    expect(page).to have_content 'Articles'
    expect(page).to have_content 'Rubrics'
  end

end
