module ComicVine
  module Helpers

    extend self

    ##
    # Parses sting and returns the issue Comic Vine ID from it
    #
    # @param [String] url
    # @return [String]
    # @since 0.1.0
    def get_issue_id_from_url(url)
      match = url.to_s.match(/www.comicvine.com.*4000\-([\d]+)\/?/)
      if defined? match
        match[1]
      else
        nil
      end
    end

    ##
    # Returns a +ComicTagger::ComicVine::Client+ instance
    #
    # @return [ComicTagger::ComicVine::Client]
    # @since 0.1.0
    def get_client
      ComicVine::Client.new(ENV['CV_API_KEY'])
    end

  end
end
