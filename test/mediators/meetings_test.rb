require "test_helper"

describe Toastmasters::Mediators::Meetings do
  include TestHelpers

  describe ".all" do
    it "orders by last name" do
      Meeting.create(date: Date.new(2015, 12, 31))
      Meeting.create(date: Date.new(2016, 1, 1))

      meetings = Mediators::Meetings.all

      assert_equal [2016, 2015], meetings.map { |m| m.date.year }
    end
  end

  describe ".find" do
    it "finds the record" do
      meeting = Meeting.create(date: Date.today)

      assert_equal meeting, Mediators::Meetings.find(meeting.id)
    end

    it "raises an error if record wasn't found" do
      assert_raises(Error::ResourceNotFound) { Mediators::Meetings.find(123) }
    end
  end

  describe ".create" do
    it "creates the record" do
      meeting = Mediators::Meetings.create(date: Date.today)

      refute meeting.new?
    end

    it "raises validation errors" do
      assert_raises(Error::ValidationFailed) { Mediators::Meetings.create({}) }
    end
  end

  describe ".update" do
    it "updates the record" do
      meeting = Meeting.create(date: Date.today)
      Mediators::Meetings.update(meeting.id, note: "Note")

      assert_equal "Note", meeting.reload.note
    end

    it "raises validation errors" do
      meeting = Meeting.create(date: Date.today)

      assert_raises(Error::ValidationFailed) { Mediators::Meetings.update(meeting.id, {date: nil}) }
    end
  end

  describe ".delete" do
    it "destroys the record" do
      meeting = Meeting.create(date: Date.today)
      meeting = Mediators::Meetings.delete(meeting.id)

      refute meeting.exists?
    end
  end
end
