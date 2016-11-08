module ComicVine
  module TypeAttributes
    module Character
      attr_accessor :aliases, :api_detail_url, :birth, :character_enemies, :character_friends,
                    :count_of_issue_appearances, :creators, :date_added, :date_last_updated, :deck, :description,
                    :first_appeared_in_issue, :gender, :id, :image, :issue_credits, :issues_died_in, :movies, :name,
                    :origin, :powers, :publisher, :real_name, :site_detail_url, :story_arc_credits, :team_enemies,
                    :team_friends, :teams, :volume_credits
    end

    module Chat
      attr_accessor :api_detail_url, :channel_name, :deck, :image, :password, :site_detail_url, :title
    end

    module Concept
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issue_credits, :movies, :name,
                    :site_detail_url, :start_year, :volume_credits
    end

    module Episode
      attr_accessor :aliases, :api_detail_url, :character_credits, :characters_died_in, :concept_credits, :air_date,
                    :date_added, :date_last_updated, :deck, :description, :first_appearance_characters,
                    :first_appearance_concepts, :first_appearance_locations, :first_appearance_objects,
                    :first_appearance_storyarcs, :first_appearance_teams, :has_staff_review, :id, :image,
                    :episode_number, :location_credits, :name, :object_credits, :person_credits, :site_detail_url,
                    :story_arc_credits, :team_credits, :series
    end

    module Issue
      attr_accessor :aliases, :api_detail_url, :character_credits, :characters_died_in, :concept_credits, :cover_date,
                    :date_added, :date_last_updated, :deck, :description, :disbanded_teams,
                    :first_appearance_characters, :first_appearance_concepts, :first_appearance_locations,
                    :first_appearance_objects, :first_appearance_storyarcs, :first_appearance_teams, :has_staff_review,
                    :id, :image, :issue_number, :location_credits, :name, :object_credits, :person_credits,
                    :site_detail_url, :store_date, :story_arc_credits, :team_credits, :teams_disbanded_in, :volume
    end

    module Location
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issue_credits, :movies, :name,
                    :site_detail_url, :start_year, :story_arc_credits, :volume_credits
    end

    module Movie
      attr_accessor :api_detail_url, :box_office_revenue, :budget, :characters, :concepts, :date_added,
                    :date_last_updated, :deck, :description, :distributor, :has_staff_review, :id, :image, :locations,
                    :name, :producers, :rating, :release_date, :runtime, :site_detail_url, :studios, :teams, :things,
                    :total_revenue, :writers
    end

    module Object
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issue_credits, :movies, :name,
                    :site_detail_url, :start_year, :story_arc_credits, :volume_credits
    end

    module Origin
      attr_accessor :api_detail_url, :character_set, :id, :name, :profiles, :site_detail_url
    end

    module Person
      attr_accessor :aliases, :api_detail_url, :birth, :count_of_issue_appearances, :country, :created_characters,
                    :date_added, :date_last_updated, :death, :deck, :description, :email, :gender, :hometown, :id,
                    :image, :issue_credits, :name, :site_detail_url, :story_arc_credits, :volume_credits, :website
    end

    module Power
      attr_accessor :attr_accessor, :aliases, :api_detail_url, :characters, :date_added, :date_last_updated,
                    :description, :id, :name, :site_detail_url
    end

    module Promo
      attr_accessor :api_detail_url, :date_added, :deck, :id, :image, :link, :name, :resource_type, :user
    end

    module Publisher
      attr_accessor :aliases, :api_detail_url, :characters, :date_added, :date_last_updated, :deck, :description, :id,
                    :image, :location_address, :location_city, :location_state, :name, :site_detail_url, :story_arcs,
                    :teams, :volumes
    end

    module Series
      attr_accessor :aliases, :api_detail_url, :character_credits, :count_of_episodes, :date_added, :date_last_updated,
                    :deck, :description, :first_episode, :id, :image, :last_episode, :location_credits, :name,
                    :publisher, :site_detail_url, :start_year
    end

    module StoryArc
      attr_accessor :aliases, :api_detail_url, :count_of_issue_appearances, :date_added, :date_last_updated, :deck,
                    :description, :first_appeared_in_issue, :id, :image, :issues, :movies, :name, :publisher,
                    :site_detail_url
    end

    module Team
      attr_accessor :aliases, :api_detail_url, :character_enemies, :character_friends, :characters,
                    :count_of_issue_appearances, :count_of_team_members, :date_added, :date_last_updated, :deck,
                    :description, :disbanded_in_issues, :first_appeared_in_issue, :id, :image, :issue_credits,
                    :issues_disbanded_in, :movies, :name, :publisher, :site_detail_url, :story_arc_credits,
                    :volume_credits
    end

    module Type
      attr_accessor :detail_resource_name, :list_resource_name, :id
    end

    module Video
      attr_accessor :api_detail_url, :deck, :hd_url, :high_url, :id, :image, :length_seconds, :low_url, :name,
                    :publish_date, :site_detail_url, :url, :user
    end

    module VideoCategory
      attr_accessor :api_detail_url, :deck, :id, :name, :site_detail_url
    end

    module VideoType
      attr_accessor :api_detail_url, :deck, :id, :name, :site_detail_url
    end

    module Volume
      attr_accessor :aliases, :api_detail_url, :character_credits, :concept_credits, :count_of_issues, :date_added,
                    :date_last_updated, :deck, :description, :first_issue, :id, :image, :last_issue, :location_credits,
                    :name, :object_credits, :person_credits, :publisher, :site_detail_url, :start_year, :team_credits
    end

  end
end

