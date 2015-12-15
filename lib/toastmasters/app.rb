require "roda"

require "toastmasters/serializer"
require "toastmasters/error"
require "toastmasters/json_api"

Dir["#{__dir__}/models/*.rb"].each { |f| require(f) }
Dir["#{__dir__}/mediators/*.rb"].each { |f| require(f) }

module Toastmasters
  class App < Roda
    plugin :all_verbs
    plugin :indifferent_params
    plugin :json, classes: Serializer::CLASSES, serializer: Serializer, include_request: true
    plugin :json_parser
    plugin :error_handler
    plugin :not_found

    route do |r|
      r.root do
        {message: "Welcome to Toastmasters API, you can find the documentation on https://github.com/twin/toastmasters-api#readme"}
      end

      authenticate!

      r.on "members" do
        r.is do
          r.get do
            Mediators::Members.all(params)
          end

          r.post do
            Mediators::Members.create(attributes(:member))
          end
        end

        r.is ":id" do |member_id|
          r.get do
            Mediators::Members.find(member_id)
          end

          r.patch do
            Mediators::Members.update(member_id, attributes(:member))
          end

          r.delete do
            Mediators::Members.delete(member_id)
          end
        end
      end

      r.on "guests" do
        r.is do
          r.get do
            Mediators::Guests.all(params)
          end

          r.post do
            Mediators::Guests.create(attributes(:guest))
          end
        end

        r.is ":id" do |guest_id|
          r.get do
            Mediators::Guests.find(guest_id)
          end

          r.patch do
            Mediators::Guests.update(guest_id, attributes(:guest))
          end

          r.delete do
            Mediators::Guests.delete(guest_id)
          end
        end
      end

      r.on "meetings" do
        r.is do
          r.get do
            Mediators::Meetings.all(params)
          end

          r.post do
            Mediators::Meetings.create(attributes(:meeting))
          end
        end

        r.is ":id" do |meeting_id|
          r.get do
            Mediators::Meetings.find(meeting_id)
          end

          r.patch do
            Mediators::Meetings.update(meeting_id, attributes(:meeting))
          end

          r.delete do
            Mediators::Meetings.delete(meeting_id)
          end
        end

        r.on ":id" do |meeting_id|
          r.on "participations" do
            r.is do
              r.get do
                Mediators::Participations.all(meeting_id: meeting_id)
              end

              r.post do
                Mediators::Participations.create(meeting_id, attributes(:participation))
              end
            end

            r.is ":id" do |participation_id|
              r.patch do
                Mediators::Participations.update(participation_id, attributes(:participation))
              end

              r.delete do
                Mediators::Participations.delete(participation_id)
              end
            end
          end
        end
      end

      r.on "speeches" do
        r.is do
          r.get do
            Mediators::Speeches.all
          end
        end
      end
    end

    def attributes(name)
      JsonApi.new(params).attributes(name)
    end

    def authenticate!
      if request.env["HTTP_X_API_KEY"] != opts.fetch(:api_key)
        raise Toastmasters::Error::Unauthorized
      end
    end

    error do |error|
      if Toastmasters::Error === error
        response.status = error.status
        error
      else
        raise error
      end
    end

    not_found do
      raise Toastmasters::Error::PageNotFound, request.path
    end
  end
end
