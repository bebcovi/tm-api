require "test_helper"

describe Toastmasters::Mediators::Members do
  include TestHelpers

  describe ".all" do
    it "orders by last name" do
      Member.create(first_name: "Andrew", last_name: "Laeddis", email: "andrew.laeddis@gmail.com")
      Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      assert_equal ["Daniels", "Laeddis"], Mediators::Members.all.map(&:last_name)
    end
  end

  describe ".find" do
    it "finds the record" do
      member = Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      assert_equal member, Mediators::Members.find(member.id)
    end

    it "raises an error if record wasn't found" do
      assert_raises(Error::ResourceNotFound) { Mediators::Members.find(123) }
    end
  end

  describe ".create" do
    it "creates the record" do
      member = Mediators::Members.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      refute member.new?
    end

    it "raises validation errors" do
      assert_raises(Error::ValidationFailed) { Mediators::Members.create({}) }
    end
  end

  describe ".update" do
    it "updates the record" do
      member = Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")
      Mediators::Members.update(member.id, first_name: "Andrew", last_name: "Laeddis", email: "andrew.laeddis@gmail.com")

      assert_equal "Andrew", member.reload.first_name
    end

    it "raises validation errors" do
      member = Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      assert_raises(Error::ValidationFailed) { Mediators::Members.update(member.id, {first_name: nil}) }
    end
  end

  describe ".delete" do
    it "destroys the record" do
      member = Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")
      member = Mediators::Members.delete(member.id)

      refute member.exists?
    end
  end
end
