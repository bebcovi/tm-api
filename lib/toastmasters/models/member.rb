require "toastmasters/models/base"

module Toastmasters
  module Models
    class Member < Base
      one_to_many :participations
      add_association_dependencies participations: :destroy

      def validate
        validates_presence [:first_name, :last_name]
        validates_unique :email, allow_nil: true
      end

      def speeches
        speaker_participations = participations_dataset.where(role: "Speaker").as(:participations)
        speaker_id = Sequel.pg_jsonb_op(:role_data).get_text("speech_id").cast(:integer)

        Speech.qualify
          .join(speaker_participations, speaker_id => :id)
          .join(:meetings, :id => :meeting_id)
          .order(:meetings__date)
      end
    end
  end
end
