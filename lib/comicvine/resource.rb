module ComicVine

  ##
  # Class container for a singular ComicVine resource
  # @since 0.1.0
  class Resource

    def initialize(args)
      args.each do |k, v|
        # Add an attribute reader for each key
        # noinspection RubyResolve
        self.class.class_eval { attr_reader k } unless self.respond_to? k

        # Convert sub arrays to objects
        v.collect! { |i| ComicVine::Resource::create_resource(i) } if v.kind_of?(Array) && !v.empty? && v.first.key?('api_detail_url')

        # Convert sub hashes to objects
        if v.kind_of?(Hash) && v.key?('api_detail_url')
          v = ComicVine::Resource::create_resource(v)
        end

        # Set the instance variable to value
        instance_variable_set "@#{k}", v
      end
    end

    ##
    # Fetches data from ComicVine based on objects api_detail_url
    #
    # @return [ComicVine::Resource]
    # @since 0.1.0
    def fetch
      ComicVine::API.get_details_by_url(self.api_detail_url)
    end

    ##
    # Fetches data from ComicVine based on objects api_detail_url and updates self with new values
    #
    # @return [ComicVine::Resource]
    # @since 0.1.2
    def fetch!
      obj = ComicVine::API.get_details_by_url(self.api_detail_url)
      self.methods.each do |m|
        # Look for methods that can be set (i.e. ends with a =)
        if m.to_s =~ /^(?!_)([\w\d\_]+)=$/
          # Save our method symbols in a more readable fashion
          get_m = $1.to_sym
          set_m = m

          # Skip setting ids, as this should be handled by the classes when setting the children objects if needed
          next if get_m.to_s =~ /\_ids?$/ || set_m.to_s =~ /attributes/

          # Verify the new object has a get method and it is not nil or empty
          if self.respond_to?(set_m) && obj.respond_to?(get_m) && !obj.method(get_m).call.nil?
            # Now set the method to the new value
            self.method(set_m).call obj.method(get_m).call
          end
        end
      end
      self
    end

    # @private
    def method_missing(method_sym, *arguments, &block)
      if method_sym.to_s =~ /^get_(.*)$/
        key = method_sym.to_s.sub 'get_', ''
        if instance_variable_defined?("@#{key}")
          item = instance_variable_get("@#{key}")
          if item.kind_of?(Array) && item.first.kind_of?(Resource)
            res = []
            item.each do |i|
              res << i.fetch
            end
            return res
          end
          if item.kind_of?(Resource)
            return item.fetch
          end
        else
          super
        end
      elsif super
      end
    end

    ##
    # Identifies objects resource type based on its ComicVine api_detail_url
    #
    # @return [Symbol]
    # @since 0.1.2
    def resource_type
      ComicVine::Resource(self.api_detail_url)
    end

    class << self

      ##
      # Takes hash and returns a {ComicVine::Resource}
      #
      # @param attr [Hash]
      # @return [ComicVine::Resource]
      # @since 0.1.2
      def create_resource(attr)
        ComicVine::Resource.new attr
      end

      ##
      # Parses supplied api_detail_url and returns the translated type symbol
      #
      # @param response [Hash]
      # @return [Symbol]
      # @since 0.1.2
      def identify_and_update_response(response)
        type = ComicVine::Resource::identify_type(response['api_detail_url'])

        case type
          when :first_appeared_in_issue
            type = :issue
            response['api_detail_url'].to_s.sub! 'first_appeared_in_issue', 'issue'
          when :thing
            type = :object
            response['api_detail_url'].to_s.sub! 'thing', 'object'
          when :creator
            type = :person
            response['api_detail_url'].to_s.sub! 'creator', 'person'
          when :writer
            type = :person
            response['api_detail_url'].to_s.sub! 'writer', 'person'
          when :studio
            type = :publisher
            response['api_detail_url'].to_s.sub! 'studio', 'publisher'
          when :arc
            type = :story_arc
            response['api_detail_url'].to_s.sub! 'arc', 'story_arc'
          else
        end

        type
      end

      ##
      # Parses supplied api_detail_url and returns the translated type symbol
      #
      # @param api_detail_url [String]
      # @return [Symbol]
      # @since 0.1.2
      def identify_type(api_detail_url)
        if api_detail_url.to_s =~ /comicvine\.gamespot\.com\/api\/(\w+)\/?/
          $1.to_s.to_sym
        else
          nil
        end
      end
    end
  end
end