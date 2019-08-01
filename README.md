# File-Organising App

## Description

Simple web-based application that allows users to upload files, organize them using tags, and then search for files using tags.


## Requirements

* Rails 5.2.3
* Ruby 2.6.3
* PostgreSQL


## Getting started
To get started with the app, clone the repo and then install the needed gems:

```
$ cd /path/to/repos
$ git clone [file_search_uar](https://github.com/luisdgutierrez05/file_search_uar.git)
$ cd file_search_uar
$ bundle install
```

Next, setup the database:

```
$ cp config/database.yml.sample config/database.yml and add your Postgres settings.
$ rails db:setup
$ rails db:test:prepare
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rspec spec
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```


# Code Overview

## Dependencies
- [active_model_serializers](https://github.com/rails-api/active_model_serializers) - For JSON in an object-oriented and convention-driven manner.
- [will_paginate](https://github.com/mislav/will_paginate) - For implementing pagination.
- [pgcrypto](https://lab.io/articles/2017/04/13/uuids-rails-5-1/) - For generating primary keys as UUIDs on database.

## Design

Database:
- Since PostgreSQL accepts array format as column type and Rails treats an array column in PostgreSQL as an Array in Ruby I decided to implement this in order to store the tags on database instead of creating another model and create an association with the FileResource model which is in charge of the files. For indexing I used GIN because in this case PostgreSQL recommend uses it when we are going to use arrays with static data and won't be updated frequently. For the search of tags I used contains(@>) which is definitely better than ANY because PG uses index with the contains arrays operator.

API:
- I implemented active_model_serializers library to handle and customize in an easy way the API endpoints over the JSON:API standard. I created two endpoints base on RESTful structure.

Validations:
- I added some custom validations to avoid create files with empty, duplicated and invalid format tags.

Service:
- I created a service called filter tags in order to have the files controller dry and clean. It will stay in charge of the business logic for the search with filters and the meta data required.


## Folders

- `app/controllers` - Contains the controllers where requests are routed to their actions, where we find and manipulate our models and return them for the views to render.
- `app/lib` - Contains a custom exceptions module to add all the custom exceptions.
- `app/models` - Contains the database models for the application where we can define methods, validations, queries, and relations to other models.
- `app/serializers` - Contains the serializer where resource could defined the information that will be displayed on the
endpoint response.
- `app/services` - Contains the service to filter files by tags.
- `app/validators` - Contains the file resource validations.
- `config` - Contains configuration files for our Rails application and for our database, along with an `initializers` folder for scripts that get run on boot.
- `db` - Contains the migrations needed to create our database schema.


## Endpoints

### Create File
```
Action: POST
URL: http://localhost:{port}/api/v1/files
Headers: 'Content-Type': 'application/vnd.api+json'
Body params:
  {
    "data": {
      "type": "files",
      "attributes": {
        "name": "File1",
        "tags": [
          "Tag1", "Tag2"
        ]
      }
    }
  }

Response sample:
  {
    "data": {
      "id": "9b404a39-ed1b-4a64-979d-554465d92e91",
      "type": "files",
      "attributes": {
        "name": "File1"
      }
    }
  }
```


### Filter files by tags
```
Action: GET
URL: http://localhost:{port}/api/v1/files/+Tag2 +Tag3 -Tag4/1
Headers: 'Content-Type': 'application/vnd.api+json'
Body params: none
Response sample:
  {
    "data": [
      {
        "id": "02ff28ad-5808-493b-a85f-c6ee2dce64b9",
        "type": "files",
        "attributes": {
          "name": "File 1"
        }
      },
      {
        "id": "631f1bfb-b16a-47ce-977c-5f009cc59ab4",
        "type": "files",
        "attributes": {
          "name": "File 3"
        }
      }
    ],
    "meta": {
      "total-records": 2,
      "related-tags": [
        {
          "tag": "Tag1",
          "file-count": 1
        },
        {
          "tag": "Tag5",
          "file-count": 2
        }
      ]
    }
  }
```


## Author

* **Luis Gutiérrez**
* Duration: 9 hours 21 minutes
