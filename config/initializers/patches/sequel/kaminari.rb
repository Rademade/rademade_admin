module Sequel
  class Dataset
    module Pagination

      def total_pages
        page_count
      end

      def limit_value
        page_size
      end

    end
  end
end
