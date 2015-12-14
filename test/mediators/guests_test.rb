require "test_helper"

describe Toastmasters::Mediators::Guests do
  include TestHelpers

  describe ".all" do
    it "orders by last name" do
      Guest.create(first_name: "Andrew", last_name: "Laeddis", email: "andrew.laeddis@gmail.com")
      Guest.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      assert_equal ["Daniels", "Laeddis"], Mediators::Guests.all.map(&:last_name)
    end
  end

  describe ".find" do
    it "finds the record" do
      guest = Guest.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      assert_equal guest, Mediators::Guests.find(guest.id)
    end

    it "raises an error if record wasn't found" do
      assert_raises(Error::ResourceNotFound) { Mediators::Guests.find(123) }
    end
  end

  describe ".create" do
    it "creates the record" do
      guest = Mediators::Guests.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      refute guest.new?
    end

    it "raises validation errors" do
      assert_raises(Error::ValidationFailed) { Mediators::Guests.create({}) }
    end
  end

  describe ".update" do
    it "updates the record" do
      guest = Guest.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")
      Mediators::Guests.update(guest.id, first_name: "Andrew", last_name: "Laeddis", email: "andrew.laeddis@gmail.com")

      assert_equal "Andrew", guest.reload.first_name
    end

    it "raises validation errors" do
      guest = Guest.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")

      assert_raises(Error::ValidationFailed) { Mediators::Guests.update(guest.id, {first_name: nil}) }
    end
  end

  describe ".delete" do
    it "destroys the record" do
      guest = Guest.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")
      guest = Mediators::Guests.delete(guest.id)

      refute guest.exists?
    end
  end
end
