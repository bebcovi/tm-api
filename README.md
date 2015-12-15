# Toastmasters API

Welcome to Toastmasters API documentation.

## Setup

* `brew install postgres` (>= 9.4)
* `rbenv install 2.2.2; rbenv global 2.2.2`
* `gem install bundler foreman`
* `bundle install`
* `createdb toastmasters; bundle exec rake db:migrate`
* `foreman start`

## Table of contents

* [**Introduction**](#introduction)
* [**Meetings**](#meetings)
* [**Members**](#members)
* [**Guests**](#guests)
* [**Participations**](#participations)
* [**Speeches**](#speeches)

## Introduction

The format used for requests and responses is [JSON API], with the media type
[application/vnd.api+json].

In every request you should include the API key that was provided to you in
the `X-Api-Key` header:

```http
GET /meetings HTTP/1.1
X-Api-Key: 0234kg9fgkas9l329dfg044
```

Errors that happen in the request will be returned, and sometimes the "meta"
key will return error data:

```http
HTTP/1.1 401 Unauthorized
Content-Type: application/json

{
  "errors": [
    {
      "id": "unauthorized",
      "title": "The request requires authentication",
      "status": 401,
      "meta": {}
    }
  ]
}
```

## Meetings

| Attribute | Type   |
| --------- | ----   |
| `id`      | string |
| `date`    | date   |
| `note`    | string |

When singular meetings are returned, a list of participations will also be
returned.

### Listing meetings

```http
GET /meetings HTTP/1.1
```

```http
GET /meetings/43 HTTP/1.1
```

### Creating meetings

```http
POST /meetings HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "meetings",
    "attributes": {
      "date": "2015-01-01",
    }
  }
}
```

### Updating meetings

```http
PATCH /meetings/43 HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "meetings",
    "id": "43",
    "attributes": {
      "note": "A note about the meeting",
    }
  }
}
```

### Deleting meetings

```http
DELETE /meetings/43 HTTP/1.1
```

## Members

| Attribute    | Type   |
| ---------    | ----   |
| `id`         | string |
| `first_name` | string |
| `last_name`  | string |
| `email`      | string |
| `active`     | boolean |

### Listing members

```http
GET /members HTTP/1.1
```

```http
GET /members/43 HTTP/1.1
```

### Creating members

```http
POST /members HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "members",
    "attributes": {
      "first_name": "John",
      "last_name": "Smith",
      "email": "john.smith@gmail.com",
    }
  }
}
```

### Updating members

```http
PATCH /members/43 HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "members",
    "id": "43",
    "attributes": {
      "active": false,
    }
  }
}
```

### Deleting members

```http
DELETE /members/43 HTTP/1.1
```

## Guests

| Attribute    | Type   |
| ---------    | ----   |
| `id`         | string |
| `first_name` | string |
| `last_name`  | string |
| `email`      | string |

### Listing guests

```http
GET /guests HTTP/1.1
```

```http
GET /guests/43 HTTP/1.1
```

### Creating guests

```http
POST /guests HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "guests",
    "attributes": {
      "first_name": "John",
      "last_name": "Smith",
      "email": "john.smith@gmail.com",
    }
  }
}
```

If a guest already exists with given attributes, returns it rather than
creating a new one.

### Updating guests

```http
PATCH /guests/43 HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "guests",
    "id": "43",
    "attributes": {
      "first_name": "Edward",
    }
  }
}
```

### Deleting guests

```http
DELETE /guests/43 HTTP/1.1
```

## Participations

| Attribute   | Type   |
| ---------   | ----   |
| `id`        | string |
| `role`      | string |
| `role_data` | json   |

Valid roles are:

| `role`               | `role_data`            |
| ---------            | -----------            |
| `Toastmaster`        |                        |
| `General Evaluator`  |                        |
| `Speaker`            | `{"speech_id": "123"}` |
| `Evaluator`          | `{"speaker_id": "22"}` |
| `Table TopicsMaster` |                        |
| `Timer`              |                        |
| `Grammarian`         |                        |
| `Ah-Counter`         |                        |

Participations have associations `meeting`, `member` and `guest`.

### Listing participations

```http
GET /meetings/12/participations HTTP/1.1
```

### Creating participations

```http
POST /meetings/12/participations HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "participations",
    "attributes": {
      "role": "Evaluator",
      "role_data": {}
    },
    "relationships": {
      "member": {
        "data": {"type": "members", "id": "25"}
      }
    }
  }
}
```

We can create either a "member" or a "guest" participation by putting the
appropriate name in "relationships".

```json
{"relationships": {"member": {"data": {"type": "members", "id": "25"}}}}
{"relationships": {"guest": {"data": {"type": "guests", "id": "42"}}}}
```

### Updating participations

```http
PATCH /meetings/12/participations/43 HTTP/1.1
Content-Type: application/json

{
  "data": {
    "type": "participations",
    "id": "43",
    "attributes": {
      "role_data": {"speaker_id": 22},
    }
  }
}
```

### Deleting participations

```http
DELETE /meetings/12/participations/43 HTTP/1.1
```

## Speeches

| Attribute | Type    |
| --------- | ----    |
| `id`      | string  |
| `title`   | string  |
| `number`  | integer |

### Listing speeches

```http
GET /speeches HTTP/1.1
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": [{
    "type": "speeches",
    "id": "25",
    "attributes": {
      "title": "How to Say it",
      "number": 4
    },
    "relationships": {
      "manual": {
        "data": {"type": "manuals", "id": "7"}
      }
    }
  }],
  "included": [{
    "type": "manuals",
    "id": "7",
    "attributes": {
      "name": "Competent Communicator"
    }
  }]
}
```

[JSON API]: http://jsonapi.org/
[application/vnd.api+json]: http://www.iana.org/assignments/media-types/application/vnd.api+json
