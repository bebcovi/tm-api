require "test_helper"

describe Toastmasters::App do
  include TestHelpers

  it "returns root path" do
    response = app.get("/")

    refute_empty response.body_json["message"]
  end

  it "authenticates" do
    response = app.get("/members")

    assert_equal 401, response.status
  end

  it "returns errors properly" do
    response = app.get("/members")
    error = response.body_json.fetch("errors")[0]

    assert_equal "unauthorized",   error["id"]
    assert_equal 401,              error["status"]
    assert_match /authentication/, error["title"]

    response = app.get("/members/1", env: auth)
    error = response.body_json.fetch("errors")[0]

    assert_equal "resource_not_found", error["id"]
    assert_equal 404,                  error["status"]
    assert_equal "Resource not found", error["title"]

    response = app.get("/foo", env: auth)
    error = response.body_json.fetch("errors")[0]

    assert_equal "page_not_found",        error["id"]
    assert_equal 404,                     error["status"]
    assert_equal "Route not found: /foo", error["title"]
  end

  it "manages members" do
    response = app.post("/members", env: auth, json: {
      data: {
        type: "member",
        attributes: {
          first_name: "John",
          last_name: "Smith",
          email: "john.smith@gmail.com",
        },
      }
    })
    refute_empty response.body_json["data"]

    response = app.get("/members", env: auth)
    refute_empty response.body_json["data"]

    member_id = response.body_json["data"][0]["id"]
    response = app.patch("/members/#{member_id}", env: auth, json: {
      data: {
        type: "member",
        id: member_id,
        attributes: {first_name: "Janko"}
      }
    })
    assert_equal "Janko", response.body_json["data"]["attributes"]["first_name"]

    response = app.delete("/members/#{member_id}", env: auth)
    refute_empty response.body_json["data"]
  end

  it "manages guests" do
    response = app.post("/guests", env: auth, json: {
      data: {
        type: "guest",
        attributes: {
          first_name: "John",
          last_name: "Smith",
          email: "john.smith@gmail.com",
        },
      }
    })
    refute_empty response.body_json["data"]

    response = app.get("/guests", env: auth)
    refute_empty response.body_json["data"]

    guest_id = response.body_json["data"][0]["id"]
    response = app.patch("/guests/#{guest_id}", env: auth, json: {
      data: {
        type: "guest",
        id: guest_id,
        attributes: {first_name: "Janko"}
      }
    })
    assert_equal "Janko", response.body_json["data"]["attributes"]["first_name"]

    response = app.delete("/guests/#{guest_id}", env: auth)
    refute_empty response.body_json["data"]
  end

  it "manages meetings" do
    response = app.post("/meetings", env: auth, json: {
      data: {
        type: "meeting",
        attributes: {date: Date.today},
      }
    })
    refute_empty response.body_json["data"]

    response = app.get("/meetings", env: auth)
    refute_empty response.body_json["data"]

    meeting_id = response.body_json["data"][0]["id"]
    response = app.patch("/meetings/#{meeting_id}", env: auth, json: {
      data: {
        type: "meeting",
        id: meeting_id,
        attributes: {date: Date.new(2015)}
      }
    })
    assert_equal Date.new(2015).iso8601, response.body_json["data"]["attributes"]["date"]

    response = app.delete("/meetings/#{meeting_id}", env: auth)
    refute_empty response.body_json["data"]

    assert_equal 404, app.get("meetings/#{meeting_id}", env: auth).status
  end
end
