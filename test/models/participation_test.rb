require "test_helper"

describe Toastmasters::Models::Participation do
  include TestHelpers

  before do
    @meeting = Meeting.create(date: Date.today)
    @member = Member.create(first_name: "Edward", last_name: "Daniels", email: "edward.daniels@gmail.com")
  end

  it "accepts role data" do
    participation = Participation.create(role_data: {foo: "bar"}, meeting: @meeting, member: @member)

    assert_equal Hash["foo" => "bar"], participation.role_data
  end
end
