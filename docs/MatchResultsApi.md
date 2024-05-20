# FtcEventsClient::MatchResultsApi

All URIs are relative to *http://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_matches_event_code_get**](MatchResultsApi.md#v20_season_matches_event_code_get) | **GET** /v2.0/{season}/matches/{eventCode} | Event Match Results
[**v20_season_scores_event_code_tournament_level_get**](MatchResultsApi.md#v20_season_scores_event_code_tournament_level_get) | **GET** /v2.0/{season}/scores/{eventCode}/{tournamentLevel} | Score Details

# **v20_season_matches_event_code_get**
> EventMatchResultsModelVersion2 v20_season_matches_event_code_get(season, event_code, opts)

Event Match Results

The match results API returns the match results for all matches of a particular event in a particular season. Match results are only available once a match has been played, retrieving info about future matches requires the event schedule API. You cannot receive data about a match that is in progress. You can, however, request the Hybrid Schedule if you would like data about upcoming and played matches at the same time.   If you specify the `matchNumber`, `start` and/or `end` optional parameters, you must also specify a `tournamentLevel`. If you specify the `teamNumber` parameter, you cannot specify a `matchNumber` parameter. If you specify the `matchNumber`, you cannot define a start or end.   Note: If you specify `start`, and it is higher than the maximum match number at the event, you will not receive any match results in the response. The same is true in reverse for the `end` parameter.

### Example
```ruby
# load the gem
require 'ftc_events_client'
# setup authorization
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
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the match results are requested. Must be 4 digits. | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the results are requested. Must be at least 3 characters. | 
 **tournament_level** | **String**| Required tournamentLevel of desired score details. | [optional] [default to 0]
 **team_number** | **Integer**| &#x60;teamNumber&#x60; to search for within the results. Only returns match results in which the requested team was a participant. | [optional] 
 **match_number** | **Integer**| specific single &#x60;matchNumber&#x60; of result. | [optional] 
 **start** | **Integer**| &#x60;start&#x60; match number for subset of results to return. | [optional] [default to 0]
 **_end** | **Integer**| &#x60;end&#x60; match number for subset of results to return (inclusive). | [optional] [default to 999]

### Return type

[**EventMatchResultsModelVersion2**](EventMatchResultsModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **v20_season_scores_event_code_tournament_level_get**
> MatchScoresModel v20_season_scores_event_code_tournament_level_get(season, event_code, tournament_level, opts)

Score Details

The score details API returns the score detail for all matches of a particular event in a particular season and a particular tournament level. Score details are only available once a match has been played, retrieving info about future matches requires the event schedule API. You cannot receive data about a match that is in progress.

### Example
```ruby
# load the gem
require 'ftc_events_client'
# setup authorization
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
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the match results are requested. Must be 4 digits. | 
 **event_code** | **String**| Case insensitive alphanumeric eventCode of the event from which the details are requested. Must be at least 3 characters. | 
 **tournament_level** | **String**| Required tournamentLevel of desired score details. | 
 **team_number** | **Integer**| &#x60;teamNumber&#x60; to search for within the results. Only returns details in which the requested team was a participant. | [optional] 
 **match_number** | **Integer**| specific single &#x60;matchNumber&#x60; of result. | [optional] 
 **start** | **Integer**| &#x60;start&#x60; match number for subset of results to return (inclusive). | [optional] [default to 0]
 **_end** | **Integer**| &#x60;end&#x60; match number for subset of results to return (inclusive). | [optional] [default to 999]

### Return type

[**MatchScoresModel**](MatchScoresModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



