module ComicVine

  ##
  # Enumerable list for multiple ComicVine results
  # @since 0.1.0
  class List
    include Enumerable

    attr_reader :total_count
    attr_reader :page_count
    attr_reader :offset
    attr_reader :limit
    attr_reader :cvos

    def initialize(resp)
      @total_count = resp['number_of_total_results']
      @page_count = resp['number_of_page_results']
      @offset = resp['offset']
      @limit = resp['limit']
    end

    def each
      @cvos.each { |c| yield c }
    end

    def last
      @cvos.last
    end

    # Returns the current page the object is on
    # @return [Integer]
    def page
      (self.offset / self.limit) + 1
    end

    # Returns the total number of pages available
    # @return [Integer] Total number of pages
    # @since 0.1.3
    def total_pages
      (self.total_count / self.limit) + 1
    end

    # Returns if there are more pages to load
    # @return [true, false]
    # @since 0.1.3
    def has_more?
      self.total_pages > self.page ? true : false
    end

    protected

    def update_ivals(new_cvol)
      @total_count = new_cvol.total_count
      @offset = new_cvol.offset || 0
      @limit = new_cvol.limit || 0
      @cvos = new_cvol.cvos
    end

  end

  ##
  # Class container for multiple ComicVine resources
  # @since 0.1.0
  class ResourceList < List
    attr_reader :resource

    def initialize(resp, resc)
      super(resp)

      @resource = resc
      @cvos = resp['results'].map { |r| ComicVine::Resource.create_resource(r) }
    end

    # Loads the next page results
    def next_page
      return nil if (@offset + @page_count) >= @total_count
      update_ivals(ComicVine::API.send(@resource, {:limit => @limit, :offset => (@offset + @page_count)}))
    end

    # Loads the previous page results
    def prev_page
      return nil if @offset == 0
      update_ivals(ComicVine::API.send(@resource, {:limit => @limit, :offset => (@offset - @page_count)}))
    end

    alias_method :next_page!, :next_page
    alias_method :prev_page!, :prev_page

  end

  ##
  # Class container for ComicVine search results
  # @since 0.1.0
  class SearchResults < List
    attr_reader :resource
    attr_reader :query

    def initialize(resp, resc, query)
      super(resp)

      @resource = resc
      @query = query
      @cvos = resp['results'].map { |r| ComicVine::Resource.create_resource(r) }
    end

    ##
    # Moves search to the next offset results
    def next_page
      return nil if (@offset + @page_count) >= @total_count
      update_ivals(ComicVine::API.search(@resource, @query, {:limit => @limit, :page => (((@offset + @page_count) / @limit) + 1)}))
    end

    ##
    # Moves search to the previous offset results
    def prev_page
      return nil if @offset == 0
      update_ivals(ComicVine::API.search(@resource, @query, {:limit => @limit, :page => (@offset / @limit)}))
    end
  end
end