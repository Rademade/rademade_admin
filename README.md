rademade_admin
========

[![Gem Version](http://img.shields.io/gem/v/rademade_admin.svg)][gem]
[![Build Status](https://travis-ci.org/Rademade/rademade_admin.svg?branch=master)][travis-ci]
[![Coverage Status](https://coveralls.io/repos/Rademade/rademade_admin/badge.png)][coveralls]
[![Code Climate](http://img.shields.io/codeclimate/github/Rademade/rademade_admin.svg)][codeclimate]
[![PullReview stats](https://www.pullreview.com/github/Rademade/rademade_admin/badges/master.svg?)][pullreview]


[gem]: https://rubygems.org/gems/rademade_admin
[travis-ci]: https://travis-ci.org/Rademade/rademade_admin
[coveralls]: https://coveralls.io/r/Rademade/rademade_admin
[codeclimate]: https://codeclimate.com/github/Rademade/rademade_admin
[pullreview]: https://www.pullreview.com/github/Rademade/rademade_admin/reviews/master

**Best rails admin panel!**

Live demo
--------------
1. [http://admin.rademade.com/login](http://admin.rademade.com/login)
2. Login: mrtom@rademade.com
3. Password: 123456

How to install
--------------
[https://github.com/Rademade/rademade_admin/wiki/install](https://github.com/Rademade/rademade_admin/wiki/install)


Supported options
--------------
```ruby
options do
  model 'ModelName'

  # Fixed table head if need
  fixed_thead true
  
  # Navigation menu settings
  parent_menu 'ModelName'

  # Setting for list data (index action)
  # list :attr, :attr_other
  list do
    
  end
  
  # Settings for form
  # form :attr, :attr_other
  form do
    attr :boolean #Other :text, :file, :editor
  end
  
  labels do
    attr 'Label for attribute'
  end
  
end
```
