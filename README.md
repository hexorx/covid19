# Covid 19 Rails API

This rails 6 app consumes the feed of covid19 daily reports by state from [](https://covidtracking.com/data/api) and provides an API for different ways to view that data. 

## Setup

The standard setup process will get everything going and seed the db with the historical data from the feed.

``` bash
> bundle install
> rake db:prepare
```

## Sync the feed

Two rake tasks are provided to sync either todays current reports or do a full sync with all historical data.

``` bash
> rake sync:current
> rake sync:full
```

## The Endpoints

The restful json api exposes five main endpoints all under the /api/v1 namespace.

### List of available states

A paginated list of state codes and names.

GET /api/v1/states 

**Params**

```
page(integer) > set which page is being returned
per_page(integer, default: 100) > set how many states are returned per page 
```

**Response**

``` json
{
  "current_page":1,
  "per_page":100,
  "total_entries":56,
  "states":[
    {
      "code":"ak",
      "name":"Alaska",
      "id":"ak"
    }, ...
  ]
}
```

### Metadata by state

All the metadata for a state.

GET /api/v1/states/{id}

**Params**

```
id(string) > two character state abbreviation 
```

**Example Response**

/api/v1/states/hi

``` json
{
  "id":"hi",
  "code":"hi",
  "name":"Hawaii",
  "notes":"notes ...",
  "site":null,
  "twitter":"@HIgov_Health",
  "created_at":"2020-11-12T05:43:05.749Z",
  "updated_at":"2020-11-12T05:43:05.749Z"
} 
```

### Daily reports by state

Paginated list of all reports by state most recent first.

GET /api/v1/states/{id}/reports

**Params**

```
id(string) > two character state abbreviation 
page(integer) > set which page is being returned
per_page(integer, default: 100) > set how many states are returned per page 
```

**Example Response**

/api/v1/states/hi/reports

``` json
{
  "current_page":1,
  "per_page":30,
  "total_entries":253,
  "state":{
    "code":"hi",
    "name":"Hawaii",
    "notes":"",
    "site":null,
    "twitter":"@HIgov_Health",
    "created_at":"2020-11-12T05:43:05.749Z",
    "updated_at":"2020-11-12T05:43:05.749Z"
  },
  "reports":[
    {
      "id":3832,
      "date":20201111,
      "state_id":"hi",
      "deaths":222,
      "hospitalized":77,
      "positive":16320,
      "created_at":"2020-11-12T05:43:34.477Z",
      "updated_at":"2020-11-12T05:43:34.477Z"
    }, ...
  ]
}
```

### Create new search

Creates a new search or finds an existing search if the params are the same and returns the results.

A search is a range of a start date and end date. The results are aggregate values grouped by state. This lets you see cases and death stats for the given range. Future enhancements could include more stats in the results, the ability to save or favorite a search by user, and order_by fields.

POST /api/v1/searches

**Params**

```
start(integer) > Range start as integer representing year, month, and day in the format YYYYMMDD
end(integer) > Range end as integer representing year, month, and day in the format YYYYMMDD
```

**Example Response**

/api/v1/searches

``` json
{
  "id": 1,
  "start": 20201108,
  "end": 20201109,
  "created_at": "2020-11-12T07:28:34.060Z",
  "updated_at": "2020-11-12T07:28:34.060Z",
  "results": [
    {
      "state_id": "ak",
      "max_deaths": 84,
      "min_deaths": 84,
      "avg_deaths": "84.0"
    }, ...
  ]
}
```

### View search by id

Return a search and it's results based on the id

GET /api/v1/searches/{id}

**Params**

```
id(integer) > id of the search
```

**Example Response**

/api/v1/searches/1

``` json
{
  "id": 1,
  "start": 20201108,
  "end": 20201109,
  "created_at": "2020-11-12T07:28:34.060Z",
  "updated_at": "2020-11-12T07:28:34.060Z",
  "results": [
    {
      "state_id": "ak",
      "max_deaths": 84,
      "min_deaths": 84,
      "avg_deaths": "84.0"
    }, ...
  ]
}
```
