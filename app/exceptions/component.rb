class ComponentException < Exception

  class << self
    def wrong_globalize
      new('With rails > 4.2 need to use globalize > 5.0')
    end
  end

end