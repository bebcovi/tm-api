require "test_helper"

describe Toastmasters::Mediators::Participations do
  include TestHelpers

  before do
    @meeting = Meeting.create(date: Date.today)
    @member = Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")
  end

  describe ".all" do
    it "lists all participations" do
      Participation.create(meeting: @meeting, role: "Speaker", member: @member)
      Participation.create(meeting: @meeting, role: "Evaluator", member: @member)

      participations = Mediators::Participations.all(meeting_id: @meeting.id)

      assert_equal ["Speaker", "Evaluator"], participations.map(&:role)
    end
  end

  describe ".create" do
    it "creates the record" do
      participation = Mediators::Participations.create(@meeting.id, {role: "Speaker", member_id: @member.id})

      refute participation.new?
    end

    it "raises validation errors" do
      assert_raises(Error::ValidationFailed) { Mediators::Participations.create(nil, {}) }
    end
  end

  describe ".update" do
    it "updates the record" do
      participation = Participation.create(meeting: @meeting, role: "Speaker", member: @member)
      Mediators::Participations.update(participation.id, role: "Evaluator")

      assert_equal "Evaluator", participation.reload.role
    end

    it "raises validation errors" do
      participation = Participation.create(meeting: @meeting, role: "Speaker", member: @member)

      assert_raises(Error::ValidationFailed) { Mediators::Participations.update(participation.id, {meeting_id: nil}) }
    end
  end

  describe ".delete" do
    it "destroys the record" do
      participation = Participation.create(meeting: @meeting, role: "Speaker", member: @member)
      participation = Mediators::Participations.delete(participation.id)

      refute participation.exists?
    end
  end
end
