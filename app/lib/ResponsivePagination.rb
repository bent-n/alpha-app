class ResponsivePagination < WillPaginate::ViewHelpers::LinkRenderer
  protected   
    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, @options[:previous_label], 'col-md-4 previous_page')
    end
      
    def next_page
      num = @collection.current_page < total_pages && @collection.current_page + 1
      previous_or_next_page(num, @options[:next_label], 'col-md-4 next_page')
    end
  end
end
