# ftc_events_client

FtcEventsClient - the Ruby gem for the FTC Events API

FTC Events API is a service to return relevant information about the _FIRST_ Tech Challenge (FTC). Information is made available from events operating around the world  Information is currently made available after the conclusion of the tournament.  The API will provide data as soon as it has synced, and we do not add any artificial delays.  ## Documentation Notes  ### Timezones  All times are listed in the local time to the event venue. HTTP-date values will show their timezone.  ### Query Parameters  If you specify a parameter, but no value for that parameter, it will be ignored. For example, if you request `URL?teamNumber=` the `teamNumber` parameter would be ignored.  For all APIs that accept a query string in addition to the base URI, the order of parameters do not matter, but the name shown in the documentation must match exactly, as does the associated value format as described in details.  For response codes that are not HTTP 200 (OK), the documentation will show a body message that represents a possible response value. While the \"title\" of the HTTP Status Code will match those shown in the response codes documentation section exactly, the body of the response will be a more detailed explanation of why that status code is being returned and may not always be exactly as shown in the examples.  ### Experimenting with the API  This documentation is rendered at both [api-docs](https://ftc-events.firstinspires.org/api-docs) and [try-it-out](https://ftc-events.firstinspires.org/try-it-out).  [api-docs](https://ftc-events.firstinspires.org/api-docs) has a three panel, easy to read layout, while [try-it-out](https://ftc-events.firstinspires.org/try-it-out) has a feature that allows you try out endpoints from within the page.  Additionally, the Open API Json is availabe at [Open API](https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json).  This can be imported into a tool such as [Postman](https://www.postman.com) for experimentation as well.   ### Last-Modified, FMS-OnlyModifiedSince, and If-Modified-Since Headers The FTC Events API utilizes the `Last-Modified` and `If-Modified-Since` Headers to communicate with consumers regarding the age of the data they are requesting. With a couple of exceptions, all calls will return a `Last-Modified` Header set with the time at which the data at that endpoint was last modified. The Header will always be set in the HTTP-date format, as described in the HTTP Protocol. There are two exceptions: the `Last-Modified` Header is not set if the endpoint returns no results (such as a request for a schedule with no matches).  Consumers should keep track of the `Last-Modified` Header, and return it on subsequent calls to the same endpoint as the If-Modified-Since. The server will recognize this request, and will only return a result if the data has been modified since the last request. If no changes have been made, an HTTP 304 will be returned. If data has been modified, ALL data on that call will be returned (for \"only modified\" data, see below).  The FTC Events API also allows a custom header used to filter the return data to a specific subset. This is done by specifying a `FMS-OnlyModifiedSince` header with each call. As with the `If-Modified-Since` header, consumers should keep track of the Last-Modified Header, and return it on subsequent calls to the same endpoint as the `FMS-OnlyModifiedSince` Header. The server will recognize this request, and will only return a result if the data has been modified since the last request, and, if returned, the data will only be those portions modified since the included date. If no changes, have been made, an HTTP 304 will be returned. Using this method, the server and consumer save processing time by only receiving modified data that is in need of update on the consumer side.  If the Headers are improperly passed (such as the wrong Day of Week for the matching date, or a date in the future), the endpoint will simply ignore the Header and return all results. If both headers are specified, the request will be denied.  ## Response Codes  The FTC Events API HTTP Status Codes correspond with the [common codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html), but occasionally with different \"titles\". The \"title\" used by the API is shown next to each of the below possible response HTTP Status Codes. Throughout the documentation, Apiary may automatically show the common \"title\" in example returns (like \"Not Found\" for 404) but on the production server, the \"title\" will instead match those listed below.  ### HTTP 200 - \"OK\" The request has succeeded. An entity corresponding to the requested resource is sent in the response. This will be returned as the HTTP Status Code for all request that succeed, even if the body is empty (such as an event that has no rankings, but with a valid season and event code were used)  ### HTTP 304 - \"Not Modified\" When utilizing a Header that allows filtered data returns, such as `If-Modified-Since`, this response indicates that no data meets the request.  ### HTTP 400 - \"Invalid Season Requested\"/\"Malformed Parameter Format In Request\"/\"Missing Parameter In Request\"/\"Invalid API Version Requested\": The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications. Specifically for this API, a 400 response indicates that the requested URI matches with a valid API, but one or more required parameter was malformed or invalid. Examples include an event code that is too short or team number that contains a letter.  ### HTTP 401 - \"Unauthorized\" All requests against the API require authentication via a valid user token. Failing to provide one, or providing an invalid one, will warrant a 401 response. The client MAY repeat the request with a suitable Authorization header field.  ### HTTP 404 - \"Invalid Event Requested\" Even though the 404 code usually indicates any not found status, a 404 will only be issued in this API when an event cannot be found for the requested season and event code. If the request didn't match a valid API or there were malformed parameters, the response would not receive a 404 but rather a 400 or 501. If this HTTP code is received, the season was a valid season and the event code matched the acceptable style of an event code, but there were no records of an event matching the combination of that season and event code. For example, HTTP 404 would be issued when the event had a different code in the requested season (the codes can change year to year based on event location).  ### HTTP 500 - \"Internal Server Error\" The server encountered an unexpected condition which prevented it from fulfilling the request. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ### HTTP 501 - \"Request Did Not Match Any Current API Pattern\" The server does not support the functionality required to fulfill the request. Specifically, the request pattern did not match any of the possible APIs, and thus processing was discontinued. This code is also issued when too many optional parameters were included in a single request and fulfilling it would make the result confusing or misleading. Each API will specify which parameters or combination of parameters can be used at the same time.  ### HTTP 503 - \"Service Unavailable\" The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a `Retry-After` header. This code will not always appear, sometimes the server may outright refuse the connection instead. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ## Authorization In order to make calls against the FTC Events API, you must include an HTTP Header called `Authorization` with the value set as specified below. If a request is made without this header, processing stops and an HTTP 401 is issued. All `Authorization` headers follow the same format:  ``` Authorization: Basic 000000000000000000000000000000000000000000000000000000000000 ```  Where the Zeros are replaced by your Token. The Token can be formed by taking your username and your AuthorizationKey and adding a colon. For example, if your username is `sampleuser` and your AuthorizationKey is `7eaa6338-a097-4221-ac04-b6120fcc4d49` you would have this string:  ``` sampleuser:7eaa6338-a097-4221-ac04-b6120fcc4d49 ```  This string must then be encoded using Base64 Encoded to form the Token, which will be the same length as the example above, but include letters and numbers. For our example, we would have:  ``` c2FtcGxldXNlcjo3ZWFhNjMzOC1hMDk3LTQyMjEtYWMwNC1iNjEyMGZjYzRkNDk= ```  Most API client libraries can handle computing the authorization header using a username and password for you  NOTICE: Publicly distributing an application, code snippet, etc, that has your username and token in it, encoded or not, WILL result in your token being blocked from the API. Each user should apply for their own token.  If you wish to acquire a token for your development, you may do so by requesting a token through our automated system on this website. 

This SDK is automatically generated by the [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) project:

- API version: v2.0
- Package version: 0.2.2
- Build package: io.swagger.codegen.v3.generators.ruby.RubyClientCodegen

## Installation

### Build a gem

To build the Ruby code into a gem:

```shell
gem build ftc_events_client.gemspec
```

Then either install the gem locally:

```shell
gem install ./ftc_events_client-0.2.2.gem
```
(for development, run `gem install --dev ./ftc_events_client-0.2.2.gem` to install the development dependencies)

or publish the gem to a gem hosting service, e.g. [RubyGems](https://rubygems.org/).

Finally add this to the Gemfile:

    gem 'ftc_events_client', '~> 0.2.2'

### Install from Git

If the Ruby gem is hosted at a git repository: https://github.com/GIT_USER_ID/GIT_REPO_ID, then add the following in the Gemfile:

    gem 'ftc_events_client', :git => 'https://github.com/GIT_USER_ID/GIT_REPO_ID.git'

### Include the Ruby code directly

Include the Ruby code directly using `-I` as follows:

```shell
ruby -Ilib script.rb
```

## Getting Started

Please follow the [installation](#installation) procedure and then run the following code:
```ruby
# Load the gem
require 'ftc_events_client'
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::AllianceSelectionApi.new
season = 56 # Integer | Numeric year of the event from which the event alliances are requested. Must be 4 digits.
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the alliance selection results are requested. Must be at least 3 characters.


begin
  #Event Alliances
  result = api_instance.v20_season_alliances_event_code_get(season, event_code)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AllianceSelectionApi->v20_season_alliances_event_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the awards are requested.
opts = { 
  team_number: 0 # Integer | `teamNumber` to search for within the results.
}

begin
  #Event Awards
  result = api_instance.v20_season_awards_event_code_get(season, event_code, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AwardsApi->v20_season_awards_event_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the awards are requested.
team_number = 56 # Integer | `teamNumber` to search for within the results.


begin
  #Event Awards
  result = api_instance.v20_season_awards_event_code_team_number_get(season, event_code, team_number)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AwardsApi->v20_season_awards_event_code_team_number_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits


begin
  #Award Listings
  result = api_instance.v20_season_awards_list_get(season)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AwardsApi->v20_season_awards_list_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits
team_number = 56 # Integer | `teamNumber` to search for within the results.
opts = { 
  event_code: '' # String | Case insensitive alphanumeric `eventCode` of the event from which the awards are requested.
}

begin
  #Event Awards
  result = api_instance.v20_season_awards_team_number_get(season, team_number, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AwardsApi->v20_season_awards_team_number_get: #{e}"
end

api_instance = FtcEventsClient::GeneralApi.new

begin
  #API Index
  result = api_instance.v20_get
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling GeneralApi->v20_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::LeaguesApi.new
season = 56 # Integer | Numeric year from which the league listings are requested. Must be 4 digits
opts = { 
  region_code: 'region_code_example', # String | Case-sensitive alphanumeric `regionCode` of a region to filter for.
  league_code: 'league_code_example' # String | Case-sensitive alphanumeric `leagueCode` of the league within the specified region to query.
}

begin
  #League Listings
  result = api_instance.v20_season_leagues_get(season, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling LeaguesApi->v20_season_leagues_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::LeaguesApi.new
season = 56 # Integer | Numeric year. Must be 4 digits
region_code = 'region_code_example' # String | Case sensitive alphanumeric `regionCode` of the region the league belongs to.
league_code = 'league_code_example' # String | Case sensitive alphanumeric `leagueCode` of the league.


begin
  #League Membership
  result = api_instance.v20_season_leagues_members_region_code_league_code_get(season, region_code, league_code)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling LeaguesApi->v20_season_leagues_members_region_code_league_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::LeaguesApi.new
season = 56 # Integer | Numeric year. Must be 4 digits
region_code = 'region_code_example' # String | Case sensitive alphanumeric `regionCode` of the region the league belongs to.
league_code = 'league_code_example' # String | Case sensitive alphanumeric `leagueCode` of the league.


begin
  #League Rankings
  result = api_instance.v20_season_leagues_rankings_region_code_league_code_get(season, region_code, league_code)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling LeaguesApi->v20_season_leagues_rankings_region_code_league_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::MatchResultsApi.new
season = 56 # Integer | Numeric year of the event from which the match results are requested. Must be 4 digits.
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the results are requested. Must be at least 3 characters.
opts = { 
  tournament_level: '0', # String | Required tournamentLevel of desired score details.
  team_number: 56, # Integer | `teamNumber` to search for within the results. Only returns match results in which the requested team was a participant.
  match_number: 56, # Integer | specific single `matchNumber` of result.
  start: 0, # Integer | `start` match number for subset of results to return.
  _end: 999 # Integer | `end` match number for subset of results to return (inclusive).
}

begin
  #Event Match Results
  result = api_instance.v20_season_matches_event_code_get(season, event_code, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling MatchResultsApi->v20_season_matches_event_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::MatchResultsApi.new
season = 56 # Integer | Numeric year of the event from which the match results are requested. Must be 4 digits.
event_code = 'event_code_example' # String | Case insensitive alphanumeric eventCode of the event from which the details are requested. Must be at least 3 characters.
tournament_level = 'tournament_level_example' # String | Required tournamentLevel of desired score details.
opts = { 
  team_number: 56, # Integer | `teamNumber` to search for within the results. Only returns details in which the requested team was a participant.
  match_number: 56, # Integer | specific single `matchNumber` of result.
  start: 0, # Integer | `start` match number for subset of results to return (inclusive).
  _end: 999 # Integer | `end` match number for subset of results to return (inclusive).
}

begin
  #Score Details
  result = api_instance.v20_season_scores_event_code_tournament_level_get(season, event_code, tournament_level, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling MatchResultsApi->v20_season_scores_event_code_tournament_level_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::RankingsApi.new
season = 56 # Integer | Numeric year of the event from which the rankings are requested. Must be 4 digits
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the rankings are requested. Must be at least 3 characters.
opts = { 
  team_number: 0, # Integer | Team number of the team whose ranking is requested.
  top: 0 # Integer | number of requested `top` ranked teams to return in result.
}

begin
  #Event Rankings
  result = api_instance.v20_season_rankings_event_code_get(season, event_code, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling RankingsApi->v20_season_rankings_event_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::ScheduleApi.new
season = 56 # Integer | Numeric year of the event from which the schedule is requested. Must be 4 digits
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the schedule are requested. Must be at least 3 characters.
opts = { 
  tournament_level: '0', # String | Required tournamentLevel of desired score details.
  team_number: 0, # Integer | `teamNumber` to search for within the schedule. Only returns matches in which the requested team participated.
  start: 0, # Integer | `start` match number for subset of results to return (inclusive).
  _end: 999 # Integer | `end` match number for subset of results to return (inclusive).
}

begin
  #Event Schedule
  result = api_instance.v20_season_schedule_event_code_get(season, event_code, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling ScheduleApi->v20_season_schedule_event_code_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::ScheduleApi.new
season = 56 # Integer | Numeric year of the event from which the hybrid schedule is requested. Must be 4 digits
event_code = 'event_code_example' # String | Case insensitive alphanumeric eventCode of the event from which the hybrid schedule is requested. Must be at least 3 characters.
tournament_level = 'tournament_level_example' # String | Required tournamentLevel of desired score details.
opts = { 
  start: 0, # Integer | `start` match number for subset of results to return (inclusive).
  _end: 999 # Integer | `end` match number for subset of results to return (inclusive).
}

begin
  #Hybrid Schedule
  result = api_instance.v20_season_schedule_event_code_tournament_level_hybrid_get(season, event_code, tournament_level, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling ScheduleApi->v20_season_schedule_event_code_tournament_level_hybrid_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::SeasonDataApi.new
season = 56 # Integer | Numeric year from which the event listings are requested. Must be 4 digits
opts = { 
  event_code: '0', # String | Case insensitive alphanumeric `eventCode` of the event about which details are requested.
  team_number: 0 # Integer | Numeric `teamNumber` of the team from which the attending event listings are requested.
}

begin
  #Event Listings
  result = api_instance.v20_season_events_get(season, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling SeasonDataApi->v20_season_events_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::SeasonDataApi.new
season = 56 # Integer | Numeric year of the event from which the season summary is requested. Must be 4 digits.


begin
  #Season Summary
  result = api_instance.v20_season_get(season)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling SeasonDataApi->v20_season_get: #{e}"
end
# Setup authorization
FtcEventsClient.configure do |config|
  # Configure HTTP basic authorization: basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = FtcEventsClient::SeasonDataApi.new
season = 56 # Integer | Numeric year from which the team listings are requested. Must be 4 digits.
opts = { 
  team_number: 0, # Integer | Numeric `teamNumber` of the team about which information is requested. Must be 1 to 5 digits.
  event_code: '0', # String | Case insensitive alphanumeric `eventCode` of the event from which details are requested.
  state: '', # String | Full legal name of the US state or international state/prov
  page: 1 # Integer | Numeric page of results to return.
}

begin
  #Team Listings
  result = api_instance.v20_season_teams_get(season, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling SeasonDataApi->v20_season_teams_get: #{e}"
end
```

## Documentation for API Endpoints

All URIs are relative to *https://ftc-api.firstinspires.org*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*FtcEventsClient::AllianceSelectionApi* | [**v20_season_alliances_event_code_get**](docs/AllianceSelectionApi.md#v20_season_alliances_event_code_get) | **GET** /v2.0/{season}/alliances/{eventCode} | Event Alliances
*FtcEventsClient::AwardsApi* | [**v20_season_awards_event_code_get**](docs/AwardsApi.md#v20_season_awards_event_code_get) | **GET** /v2.0/{season}/awards/{eventCode} | Event Awards
*FtcEventsClient::AwardsApi* | [**v20_season_awards_event_code_team_number_get**](docs/AwardsApi.md#v20_season_awards_event_code_team_number_get) | **GET** /v2.0/{season}/awards/{eventCode}/{teamNumber} | Event Awards
*FtcEventsClient::AwardsApi* | [**v20_season_awards_list_get**](docs/AwardsApi.md#v20_season_awards_list_get) | **GET** /v2.0/{season}/awards/list | Award Listings
*FtcEventsClient::AwardsApi* | [**v20_season_awards_team_number_get**](docs/AwardsApi.md#v20_season_awards_team_number_get) | **GET** /v2.0/{season}/awards/{teamNumber} | Event Awards
*FtcEventsClient::GeneralApi* | [**v20_get**](docs/GeneralApi.md#v20_get) | **GET** /v2.0 | API Index
*FtcEventsClient::LeaguesApi* | [**v20_season_leagues_get**](docs/LeaguesApi.md#v20_season_leagues_get) | **GET** /v2.0/{season}/leagues | League Listings
*FtcEventsClient::LeaguesApi* | [**v20_season_leagues_members_region_code_league_code_get**](docs/LeaguesApi.md#v20_season_leagues_members_region_code_league_code_get) | **GET** /v2.0/{season}/leagues/members/{regionCode}/{leagueCode} | League Membership
*FtcEventsClient::LeaguesApi* | [**v20_season_leagues_rankings_region_code_league_code_get**](docs/LeaguesApi.md#v20_season_leagues_rankings_region_code_league_code_get) | **GET** /v2.0/{season}/leagues/rankings/{regionCode}/{leagueCode} | League Rankings
*FtcEventsClient::MatchResultsApi* | [**v20_season_matches_event_code_get**](docs/MatchResultsApi.md#v20_season_matches_event_code_get) | **GET** /v2.0/{season}/matches/{eventCode} | Event Match Results
*FtcEventsClient::MatchResultsApi* | [**v20_season_scores_event_code_tournament_level_get**](docs/MatchResultsApi.md#v20_season_scores_event_code_tournament_level_get) | **GET** /v2.0/{season}/scores/{eventCode}/{tournamentLevel} | Score Details
*FtcEventsClient::RankingsApi* | [**v20_season_rankings_event_code_get**](docs/RankingsApi.md#v20_season_rankings_event_code_get) | **GET** /v2.0/{season}/rankings/{eventCode} | Event Rankings
*FtcEventsClient::ScheduleApi* | [**v20_season_schedule_event_code_get**](docs/ScheduleApi.md#v20_season_schedule_event_code_get) | **GET** /v2.0/{season}/schedule/{eventCode} | Event Schedule
*FtcEventsClient::ScheduleApi* | [**v20_season_schedule_event_code_tournament_level_hybrid_get**](docs/ScheduleApi.md#v20_season_schedule_event_code_tournament_level_hybrid_get) | **GET** /v2.0/{season}/schedule/{eventCode}/{tournamentLevel}/hybrid | Hybrid Schedule
*FtcEventsClient::SeasonDataApi* | [**v20_season_events_get**](docs/SeasonDataApi.md#v20_season_events_get) | **GET** /v2.0/{season}/events | Event Listings
*FtcEventsClient::SeasonDataApi* | [**v20_season_get**](docs/SeasonDataApi.md#v20_season_get) | **GET** /v2.0/{season} | Season Summary
*FtcEventsClient::SeasonDataApi* | [**v20_season_teams_get**](docs/SeasonDataApi.md#v20_season_teams_get) | **GET** /v2.0/{season}/teams | Team Listings

## Documentation for Models

 - [FtcEventsClient::AllianceModelVersion2](docs/AllianceModelVersion2.md)
 - [FtcEventsClient::AllianceScore2020](docs/AllianceScore2020.md)
 - [FtcEventsClient::AllianceSelectionModelVersion2](docs/AllianceSelectionModelVersion2.md)
 - [FtcEventsClient::ApiIndexModel](docs/ApiIndexModel.md)
 - [FtcEventsClient::AutoNavigatedStatus](docs/AutoNavigatedStatus.md)
 - [FtcEventsClient::AwardAssignmentModel](docs/AwardAssignmentModel.md)
 - [FtcEventsClient::AwardsModel](docs/AwardsModel.md)
 - [FtcEventsClient::BarcodeElement](docs/BarcodeElement.md)
 - [FtcEventsClient::EndgameParkedStatus](docs/EndgameParkedStatus.md)
 - [FtcEventsClient::EventMatchResultsModelVersion2](docs/EventMatchResultsModelVersion2.md)
 - [FtcEventsClient::EventRankingsModel](docs/EventRankingsModel.md)
 - [FtcEventsClient::EventScheduleHybridModelVersion2](docs/EventScheduleHybridModelVersion2.md)
 - [FtcEventsClient::EventScheduleModelVersion2](docs/EventScheduleModelVersion2.md)
 - [FtcEventsClient::FTCEventLevel](docs/FTCEventLevel.md)
 - [FtcEventsClient::LeagueMemberListModel](docs/LeagueMemberListModel.md)
 - [FtcEventsClient::MatchResultModelVersion2](docs/MatchResultModelVersion2.md)
 - [FtcEventsClient::MatchResultTeamModelVersion2](docs/MatchResultTeamModelVersion2.md)
 - [FtcEventsClient::MatchScoresModel](docs/MatchScoresModel.md)
 - [FtcEventsClient::OneOfMatchScoresModelMatchScoresItems](docs/OneOfMatchScoresModelMatchScoresItems.md)
 - [FtcEventsClient::ScheduleHybridModelTeamVersion2](docs/ScheduleHybridModelTeamVersion2.md)
 - [FtcEventsClient::ScheduleHybridModelVersion2](docs/ScheduleHybridModelVersion2.md)
 - [FtcEventsClient::ScheduledMatchModelVersion2](docs/ScheduledMatchModelVersion2.md)
 - [FtcEventsClient::ScheduledMatchTeamModelVersion2](docs/ScheduledMatchTeamModelVersion2.md)
 - [FtcEventsClient::ScoreDetailAllianceModel2020](docs/ScoreDetailAllianceModel2020.md)
 - [FtcEventsClient::ScoreDetailAllianceModel2021](docs/ScoreDetailAllianceModel2021.md)
 - [FtcEventsClient::ScoreDetailModel2019](docs/ScoreDetailModel2019.md)
 - [FtcEventsClient::ScoreDetailModel2020](docs/ScoreDetailModel2020.md)
 - [FtcEventsClient::ScoreDetailModel2021](docs/ScoreDetailModel2021.md)
 - [FtcEventsClient::ScoreDetailModelAlliance2019](docs/ScoreDetailModelAlliance2019.md)
 - [FtcEventsClient::ScoreDetailModelSinglePlayer2020](docs/ScoreDetailModelSinglePlayer2020.md)
 - [FtcEventsClient::ScoreDetailModelSinglePlayer2021](docs/ScoreDetailModelSinglePlayer2021.md)
 - [FtcEventsClient::ScoreDetailSinglePlayer2021](docs/ScoreDetailSinglePlayer2021.md)
 - [FtcEventsClient::SeasonAwardListingsModel](docs/SeasonAwardListingsModel.md)
 - [FtcEventsClient::SeasonAwardsModel](docs/SeasonAwardsModel.md)
 - [FtcEventsClient::SeasonEventListingsModelVersion2](docs/SeasonEventListingsModelVersion2.md)
 - [FtcEventsClient::SeasonEventModelVersion2](docs/SeasonEventModelVersion2.md)
 - [FtcEventsClient::SeasonLeagueListingsModelVersion2](docs/SeasonLeagueListingsModelVersion2.md)
 - [FtcEventsClient::SeasonLeagueModelVersion2](docs/SeasonLeagueModelVersion2.md)
 - [FtcEventsClient::SeasonSummaryModelChampionship](docs/SeasonSummaryModelChampionship.md)
 - [FtcEventsClient::SeasonSummaryModelVersion2](docs/SeasonSummaryModelVersion2.md)
 - [FtcEventsClient::SeasonTeamListingsModelVersion2](docs/SeasonTeamListingsModelVersion2.md)
 - [FtcEventsClient::SeasonTeamModelVersion2](docs/SeasonTeamModelVersion2.md)
 - [FtcEventsClient::Stone](docs/Stone.md)
 - [FtcEventsClient::TeamRankingModel](docs/TeamRankingModel.md)

## Documentation for Authorization


### basic

- **Type**: HTTP basic authentication

