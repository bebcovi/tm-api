require "test_helper"

describe Toastmasters::Models::Member do
  it "doesn't require an email" do
    Member.create(first_name: "Edward", last_name: "Daniels")
    Member.create(first_name: "Andrew", last_name: "Laeddis")

    assert_equal 2, Member.count
  end
end
