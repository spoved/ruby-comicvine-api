module ComicVine
  class Resource

    ##
    # Extends {ComicVine::Resource} to add character resource attributes
    # # @since 0.1.2
    class Character < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :birth, :character_enemies, :character_friends,
                    :count_of_issue_appearances, :creators, :date_added, :date_last_updated, :deck, :description,
                    :first_appeared_in_issue, :gender, :id, :image, :issue_credits, :issues_died_in, :movies, :name,
                    :origin, :powers, :publisher, :real_name, :site_detail_url, :story_arc_credits, :team_enemies,
                    :team_friends, :teams, :volume_credits
    end

    ##
    # Extends {ComicVine::Resource} to add chat resource attributes
    # @since 0.1.2
    class Chat < ComicVine::Resource
      attr_accessor :api_detail_url, :channel_name, :deck, :image, :password, :site_detail_url, :title
    end

    ##
    # Extends {ComicVine::Resource} to add concept resource attributes
    # @since 0.1.2
    class Concept < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issue_credits, :movies, :name,
                    :site_detail_url, :start_year, :volume_credits
    end

    ##
    # Extends {ComicVine::Resource} to add episode resource attributes
    # @since 0.1.2
    class Episode < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :character_credits, :characters_died_in, :concept_credits, :air_date,
                    :date_added, :date_last_updated, :deck, :description, :first_appearance_characters,
                    :first_appearance_concepts, :first_appearance_locations, :first_appearance_objects,
                    :first_appearance_storyarcs, :first_appearance_teams, :has_staff_review, :id, :image,
                    :episode_number, :location_credits, :name, :object_credits, :person_credits, :site_detail_url,
                    :story_arc_credits, :team_credits, :series
    end

    ##
    # Extends {ComicVine::Resource} to add issue resource attributes
    # @since 0.1.2
    class Issue < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :character_credits, :characters_died_in, :concept_credits, :cover_date,
                    :date_added, :date_last_updated, :deck, :description, :disbanded_teams,
                    :first_appearance_characters, :first_appearance_concepts, :first_appearance_locations,
                    :first_appearance_objects, :first_appearance_storyarcs, :first_appearance_teams, :has_staff_review,
                    :id, :image, :issue_number, :location_credits, :name, :object_credits, :person_credits,
                    :site_detail_url, :store_date, :story_arc_credits, :team_credits, :teams_disbanded_in, :volume
    end

    ##
    # Extends {ComicVine::Resource} to add location resource attributes
    # @since 0.1.2
    class Location < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issue_credits, :movies, :name,
                    :site_detail_url, :start_year, :story_arc_credits, :volume_credits
    end

    ##
    # Extends {ComicVine::Resource} to add movie resource attributes
    # @since 0.1.2
    class Movie < ComicVine::Resource
      attr_accessor :api_detail_url, :box_office_revenue, :budget, :characters, :concepts, :date_added,
                    :date_last_updated, :deck, :description, :distributor, :has_staff_review, :id, :image, :locations,
                    :name, :producers, :rating, :release_date, :runtime, :site_detail_url, :studios, :teams, :things,
                    :total_revenue, :writers
    end

    ##
    # Extends {ComicVine::Resource} to add object resource attributes
    # @since 0.1.2
    class Object < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issue_credits, :movies, :name,
                    :site_detail_url, :start_year, :story_arc_credits, :volume_credits
    end

    ##
    # Extends {ComicVine::Resource} to add origin resource attributes
    # @since 0.1.2
    class Origin < ComicVine::Resource
      attr_accessor :api_detail_url, :character_set, :id, :name, :profiles, :site_detail_url
    end

    ##
    # Extends {ComicVine::Resource} to add person resource attributes
    # @since 0.1.2
    class Person < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :birth, :count_of_issue_appearances, :country, :created_characters,
                    :date_added, :date_last_updated, :death, :deck, :description, :email, :gender, :hometown, :id,
                    :image, :issue_credits, :name, :site_detail_url, :story_arc_credits, :volume_credits, :website
    end

    ##
    # Extends {ComicVine::Resource} to add power resource attributes
    # @since 0.1.2
    class Power < ComicVine::Resource
      attr_accessor :attr_accessor, :aliases, :api_detail_url, :characters, :date_added, :date_last_updated,
                    :description, :id, :name, :site_detail_url
    end

    ##
    # Extends {ComicVine::Resource} to add promo resource attributes
    # @since 0.1.2
    class Promo < ComicVine::Resource
      attr_accessor :api_detail_url, :date_added, :deck, :id, :image, :link, :name, :resource_type, :user
    end

    ##
    # Extends {ComicVine::Resource} to add publisher resource attributes
    # @since 0.1.2
    class Publisher < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :characters, :date_added, :date_last_updated, :deck, :description, :id,
                    :image, :location_address, :location_city, :location_state, :name, :site_detail_url, :story_arcs,
                    :teams, :volumes
    end

    ##
    # Extends {ComicVine::Resource} to add series resource attributes
    # @since 0.1.2
    class Series < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :character_credits, :count_of_episodes, :date_added, :date_last_updated,
                    :deck, :description, :first_episode, :id, :image, :last_episode, :location_credits, :name,
                    :publisher, :site_detail_url, :start_year
    end

    ##
    # Extends {ComicVine::Resource} to add story_arc resource attributes
    # @since 0.1.2
    class StoryArc < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issues, :movies, :name, :publisher,
                    :site_detail_url
    end

    ##
    # Extends {ComicVine::Resource} to add team resource attributes
    # @since 0.1.2
    class Team < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :character_enemies, :character_friends, :characters,
                    :count_of_issue_appearances, :count_of_team_members, :date_added, :date_last_updated, :deck,
                    :description, :disbanded_in_issues, :first_appeared_in_issue, :id, :image, :issue_credits,
                    :issues_disbanded_in, :movies, :name, :publisher, :site_detail_url, :story_arc_credits,
                    :volume_credits
    end

    ##
    # Extends {ComicVine::Resource} to add type resource attributes
    # @since 0.1.2
    class Type < ComicVine::Resource
      attr_accessor :detail_resource_name, :list_resource_name, :id
    end

    ##
    # Extends {ComicVine::Resource} to add video resource attributes
    # @since 0.1.2
    class Video < ComicVine::Resource
      attr_accessor :api_detail_url, :deck, :hd_url, :high_url, :id, :image, :length_seconds, :low_url, :name,
                    :publish_date, :site_detail_url, :url, :user
    end

    ##
    # Extends {ComicVine::Resource} to add video_category resource attributes
    # @since 0.1.2
    class VideoCategory < ComicVine::Resource
      attr_accessor :api_detail_url, :deck, :id, :name, :site_detail_url
    end

    ##
    # Extends {ComicVine::Resource} to add video_type resource attributes
    # @since 0.1.2
    class VideoType < ComicVine::Resource
      attr_accessor :api_detail_url, :deck, :id, :name, :site_detail_url
    end

    ##
    # Extends {ComicVine::Resource} to add volume resource attributes
    # @since 0.1.2
    class Volume < ComicVine::Resource
      attr_accessor :aliases, :api_detail_url, :character_credits, :concept_credits, :count_of_issues, :date_added,
                    :date_last_updated, :deck, :description, :first_issue, :id, :image, :last_issue, :location_credits,
                    :name, :object_credits, :person_credits, :publisher, :site_detail_url, :start_year, :team_credits
    end

    ##
    # Extends {ComicVine::Resource} to add review resource attributes
    # @since 0.1.2
    class Review < ComicVine::Resource
      attr_accessor :api_detail_url, :id, :name, :site_detail_url

      # @private
      # @since 0.1.2
      def fetch
        self
      end

    end

  end
end

