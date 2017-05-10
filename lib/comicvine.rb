require 'comicvine/version'
require 'comicvine/list'
require 'comicvine/resource'
require 'rest-client'
require 'cgi'
require 'json'

## Yard Doc generation stuff
# @!macro [new] raise.ResourceNotSupportedError
#   @raise [ResourceNotSupportedError] indicating the resource requested is not supported
# @!macro [new] raise.ComicVineAPIError
#   @raise [ComicVineAPIError] indicating the api request code received

##
# Base ComicVine module, holds default api variables
#
module ComicVine
  # ComicVine api version (1.0)
  API_VERSION = '1.0'

  # Base ComicVine url
  API_URL = 'https://comicvine.gamespot.com/api'

  # ComicVine format (json)
  API_FORMAT = 'json'

  # Array of available resources
  API_RESOURCES = [:character, :characters, :chat, :chats, :concept, :concepts, :episode, :episodes, :issue, :issues,
                   :location, :locations, :movie, :movies, :object, :objects, :origin, :origins, :person, :people,
                   :power, :powers, :promo, :promos, :publisher, :publishers, :series, :series_list, :search, :story_arc,
                   :story_arcs, :team, :teams, :types, :video, :videos, :video_type, :video_types, :video_category,
                   :video_categories, :volume, :volumes]
  ##
  # Class to interact and query the ComicVine API
  # @since 0.1.0
  class API

    ##
    # Raised when a resource is not implemented on the current API
    #
    # Must be included in {ComicVine::API_RESOURCES}
    #
    # @since 0.1.0
    class ResourceNotSupportedError < ScriptError
    end

    ##
    # Raised when a ComicVine API error is encountered
    #
    # @since 0.1.0
    class ComicVineAPIError < ScriptError
    end

    # Hash containing ComicVine resource types and corresponding id values
    @@types = nil
    # Last time we pulled types from the API
    @@last_type_check = nil

    # ComicVine API Key. Set to the environmental variable CV_API_KEY by default if present
    @@api_key = ENV['CV_API_KEY'] || nil

    # Api response timeout in seconds
    @@api_timeout = 10

    class << self

      ##
      # @return [ComicVine::API]
      # @since 0.1.0
      def new(key)
        @@api_key=key
        self
      end

      ##
      # Returns ComicVine API Key. Set to the environmental variable CV_API_KEY by default if present
      # @return [String]
      # @since 0.1.0
      def api_key
        @@api_key || ENV['CV_API_KEY']
      end

      ##
      # Sets the ComicVine API Key. Overrides the environmental variable CV_API_KEY
      # @param key [String]
      # @since 0.1.0
      def api_key=(key)
        @@api_key = key
      end

      ##
      # Returns ComicVine API request timeout value
      # @return [Integer]
      # @since 0.1.2
      def api_timeout
        @@api_timeout
      end

      ##
      # Sets the ComicVine API request timeout value in seconds
      # @param seconds [Integer]
      # @since 0.1.0
      def api_timeout=(seconds)
        @@api_timeout = seconds.to_i
      end

      ##
      # Makes request for the current api version
      #
      # @return [String]
      # @since 0.1.0
      def get_api_version
        _make_request(:types)['version'].to_s
      end

      ##
      # Search ComicVine with the provided information
      # @example
      #   ComicVine::API.search(:volume, 'Avengers ', limit: 5)
      #
      # @param resource [Symbol] The symbol of the resource to query
      # @param query [String] The string to query
      # @param params [Hash] optional parameters to pass to CV API
      # @return [ComicVine::SearchResults]
      # @since 0.1.0
      def search(resource, query, **params)
        options = {
            resources: resource.to_s,
            query: CGI::escape(query)
        }

        options.merge! params

        ComicVine::SearchResults.new(_make_request(:search, options), resource, query)
      end

      ##
      # Returns comicvine type information
      #
      # @return [Hash]
      # @since 0.1.0
      def types
        if @@types.nil? || (@@last_type_check + (4 * 60 * 60)) < Time.now
          @@last_type_check = Time.now
          @@types = _make_request(:types)['results']
        end
        @@types
      end

      ##
      # Cycles through type hash to return the +resource+ hash of the matching the detail_resource_name
      # @example
      #   ComicVine::API.find_detail(:issue) #=> { "detail_resource_name": "issue", "list_resource_name": "issues", "id": 4000 }
      # @param resource [Symbol] The symbol of the resource to return
      # @return [Hash]
      # @since 0.1.0
      def find_detail(resource)
        types.find { |t| t['detail_resource_name'] == resource.to_s }
      end

      ##
      # Cycles through type hash to return the +resource+ hash of the matching the list_resource_name
      # @example
      #   ComicVine::API.find_list(:issues) #=> { "detail_resource_name": "issue", "list_resource_name": "issues", "id": 4000 }
      # @param resource [Symbol] The symbol of the resource to return
      # @return [Hash]
      # @since 0.1.0
      def find_list(resource)
        types.find { |t| t['list_resource_name'] == resource.to_s }
      end

      ##
      # Fetches provided
      # @example
      #   ComicVine::API.get_list(:volumes, limit: 50)
      # @param resource [Symbol] The symbol of the resource to fetch (plural)
      # @param params [Hash] optional parameters to pass to CV API
      # @return [ComicVine::ResourceList]
      # @since 0.1.0
      def get_list(resource, **params)
        resp = _make_request(resource, params)
        ComicVine::ResourceList.new(resp, resource)
      end

      ##
      # Fetches provided +resource+ with associated +id+
      # @example
      #   ComicVine::API.get_details(:issue, '371103')
      # @param resource [Symbol] The symbol of the resource to fetch
      # @param id [String] The id of the resource you would like to fetch
      # @param params [Hash] optional parameters to pass to CV API
      # @return [ComicVine::Resource]
      # @since 0.1.0
      def get_details(resource, id, **params)
        ops_hash = {
            id: id
        }
        ops_hash.merge! params
        resp = _make_request(resource, ops_hash)
        ComicVine::Resource.create_resource(resp['results'])
      end

      ##
      # Will fetch the provided +url+ as a {ComicVine::Resource}
      # @example
      #   ComicVine::API.get_details_by_url('http://comicvine.gamespot.com/api/issue/4000-371103') #=> ComicVine::Resource::Issue
      # @param url [String]
      # @return [ComicVine::Resource]
      def get_details_by_url(url)
        resp = _make_url_request(url)
        ComicVine::Resource::create_resource(resp['results'])
      end

      ##
      # Checks missing method against the resource {@@types types} and passes it to {find_list} or {get_details}
      def method_missing(method_sym, *arguments, &block)
        if find_list(method_sym)
          get_list method_sym, arguments.first
        elsif find_detail(method_sym)
          get_details method_sym, *arguments
        elsif super
        end
      end

      private

      ##
      # Builds api url string based on provided +resource+ and optional +id+
      #
      # @example Build a url for resource +:issue+ with an id of +371103+
      #   _build_base_url(:issue, '371103') #=> "http://comicvine.gamespot.com/api/issue/4000-371103"
      # @example Build a url for resource +:issues+
      #   _build_base_url(:issues) #=> "http://comicvine.gamespot.com/api/issues"
      #
      # @param resource [Symbol] The symbol of the resource to build the url for
      # @param id [String] optional id for specific resource requests
      # @return [String] Full url of the requested resource
      # @macro raise.ResourceNotSupportedError
      def _build_base_url(resource, id = nil)
        if ComicVine::API_RESOURCES.include? resource
          if !id.nil?
            API_URL + '/' + resource.to_s + '/' + "#{self.find_detail(resource)['id']}-#{id.to_s}/"
          else
            API_URL + '/' + resource.to_s + '/'
          end
        else
          raise ResourceNotSupportedError, resource.to_s + ' is not a supported resource'
        end
      end

      ##
      # Executes api request based on provided +resource+ and +params+
      #
      # @example Return 5 results from the +:characters+ resource
      #   _make_request(:characters, limit: 5)
      #
      # @param resource [Symbol] The symbol of the resource to fetch
      # @param params [Hash] The named key value pairs of query parameters
      # @return [Hash]
      # @since 0.1.0
      # @macro raise.ComicVineAPIError
      # @macro raise.ResourceNotSupportedError
      def _make_request(resource, **params)
        _make_url_request(_build_base_url(resource, params[:id] || nil), params)
      end

      ##
      # Executes api request based on provided +resource+ and +params+
      #
      # @example Make a simple request with +limit: 1+
      #   _make_url_request('http://comicvine.gamespot.com/api/issues', limit: 1)
      #
      # @param url [String] Request url
      # @param params [Hash] optional request parameters
      # @return [Hash]
      # @since 0.1.0
      # @macro raise.ComicVineAPIError
      def _make_url_request(url, **params)
        # Default options hash
        options = {
            params: {
                api_key: self.api_key,
                format: ComicVine::API_FORMAT
            }
        }

        options[:params].merge! params

        begin
          # Sleep for 1 sec to avoid rate limit
          sleep 1
          # Perform request
          request = RestClient::Request.execute(
              method: :get,
              url: url,
              timeout: self.api_timeout,
              headers: options
          )
            #request = RestClient.get(url, options)
        rescue RestClient::NotFound, RestClient::Exceptions::ReadTimeout => e
          raise ComicVineAPIError, e.message
        end

        case request.code
          when 200
            req = JSON.parse(request.body)
            if req['error'].eql?('OK')
              req
            else
              raise ComicVineAPIError, req['error']
            end
          when 420
            raise ComicVineAPIError, 'Recived a '+request.code+' http response: You\'ve been rate limited'
          else
            raise ComicVineAPIError, 'Recived a '+request.code+' http response'
        end
      end

    end
  end
end
