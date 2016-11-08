module ComicVine
  class CVObject

    def initialize(args)
      args.each do |k, v|
        # Add an attribute reader for each key
        # noinspection RubyResolve
        self.class.class_eval { attr_reader k } unless self.respond_to? k

        # Convert sub arrays to objects
        v.collect! { |i| CVObject.new i } if v.kind_of?(Array) && !v.empty? && v.first.key?('api_detail_url')

        # Convert sub hashes to objects
        v = CVObject.new v if v.kind_of?(Hash) && v.key?('api_detail_url')

        # Set the instance variable to value
        instance_variable_set "@#{k}", v
      end
    end

    def fetch
      ComicVine::API.get_details_by_url(self.api_detail_url)
    end

    def method_missing(method_sym, *arguments, &block)
      if method_sym.to_s =~ /^get_(.*)$/
        key = method_sym.to_s.sub 'get_', ''
        if instance_variable_defined?("@#{key}")
          item = instance_variable_get("@#{key}")
          if item.kind_of?(Array) && item.first.kind_of?(CVObject)
            res = []
            item.each do |i|
              res << i.fetch
            end
            return res
          end
          if item.kind_of?(CVObject)
            return item.fetch
          end
        else
          super
        end
      elsif super
      end
    end
  end
end