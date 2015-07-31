# -*- encoding : utf-8 -*-
class RademadeAdmin::PostsController < RademadeAdmin::ModelController

  options do
    list do
      headline
      status handler: Proc.new { |post| "Status #{post.status}" }
      bool_test handler: Proc.new { true }
    end
    form do
      headline
      avatar
      # gallery
      # video
      # post_time
      # text :ckeditor
      # user
      # other_posts
      # tags
      # document
      # status :as => :select,
      #        :collection => {
      #          'Новый' => '1',
      #          'Отклонен' => '2'
      #        },
      #        :include_blank => false
    end
    labels do
      headline 'Post name'
      status 'Status'
      bool_test 'Test'
    end
    csv do
      headline
      status handler: Proc.new { 'Status' }
    end
  end

end
