require 'comicvine/resource/resources'

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
          ComicVine::Resource::create_resource(v)
        end

        # Set the instance variable to value
        instance_variable_set "@#{k}", v
      end
    end

    ##
    # Fetches data from ComicVine based on objects api_detail_url
    #
    # @return [ComicVine::Resource]
    def fetch
      ComicVine::API.get_details_by_url(self.api_detail_url)
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
      # Takes hash and returns a {ComicVine::Resource} based on identified resource type
      #
      # @return [ComicVine::Resource]
      # @since 0.1.2
      def create_resource(hash)
        type = ComicVine::Resource::identify_type(hash['api_detail_url'])

        case type
          when :first_appeared_in_issue
            type = :issue
            hash['api_detail_url'].to_s.sub! 'first_appeared_in_issue', 'issue'
          when :thing
            type = :object
            hash['api_detail_url'].to_s.sub! 'thing', 'object'
          when :creator
            type = :person
            hash['api_detail_url'].to_s.sub! 'creator', 'person'
          when :review
          else
        end



        if type
          Object.class_eval('ComicVine::Resource::' + type.to_s.capitalize).new hash
        else
          raise ScriptError, 'Unknown type for api_detail_url: ' + hash['api_detail_url']
        end
      end

      ##
      # Parses supplied api_detail_url and returns the translated type symbol
      #
      # @return [Symbol]
      # @since 0.1.2
      def identify_type(api_detail_url)
        if match = api_detail_url.to_s.match(/comicvine\.gamespot\.com\/api\/(\w+)\/?/)
          match[1].to_s.to_sym
        else
          nil
        end
      end

    end
  end
end