# FtcEventsClient::ScheduleApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_schedule_event_code_get**](ScheduleApi.md#v20_season_schedule_event_code_get) | **GET** /v2.0/{season}/schedule/{eventCode} | Event Schedule
[**v20_season_schedule_event_code_tournament_level_hybrid_get**](ScheduleApi.md#v20_season_schedule_event_code_tournament_level_hybrid_get) | **GET** /v2.0/{season}/schedule/{eventCode}/{tournamentLevel}/hybrid | Hybrid Schedule



## v20_season_schedule_event_code_get

> EventScheduleModelVersion2 v20_season_schedule_event_code_get(season, event_code, opts)

Event Schedule

The schedule API returns the match schedule for the desired tournament level of a particular event in a particular season. You must also specify a `tournamentLevel` from which to return the results. Alternately, you can specify a `teamNumber` to filter the results to only those in which a particular team is participating. There is no validation that the `teamNumber` you request is actually competing at the event, if they are not, the response will be empty. You can also specify the parameters together, but cannot make a request without at least one of the two.

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
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the schedule is requested. Must be 4 digits | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the schedule are requested. Must be at least 3 characters. | 
 **tournament_level** | **String**| Required tournamentLevel of desired score details. | [optional] [default to &#39;0&#39;]
 **team_number** | **Integer**| &#x60;teamNumber&#x60; to search for within the schedule. Only returns matches in which the requested team participated. | [optional] [default to 0]
 **start** | **Integer**| &#x60;start&#x60; match number for subset of results to return (inclusive). | [optional] [default to 0]
 **_end** | **Integer**| &#x60;end&#x60; match number for subset of results to return (inclusive). | [optional] [default to 999]

### Return type

[**EventScheduleModelVersion2**](EventScheduleModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## v20_season_schedule_event_code_tournament_level_hybrid_get

> EventScheduleHybridModelVersion2 v20_season_schedule_event_code_tournament_level_hybrid_get(season, event_code, tournament_level, opts)

Hybrid Schedule

The schedule API returns the match schedule for the desired tournament level of a particular event in a particular season in the hybrid format. When a match has been played, the match result related details will be filled. When a match has not yet happened, match result related fields will be null. All parameters, except start and end, are required for the hybrid schedule.

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
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the hybrid schedule is requested. Must be 4 digits | 
 **event_code** | **String**| Case insensitive alphanumeric eventCode of the event from which the hybrid schedule is requested. Must be at least 3 characters. | 
 **tournament_level** | **String**| Required tournamentLevel of desired score details. | 
 **start** | **Integer**| &#x60;start&#x60; match number for subset of results to return (inclusive). | [optional] [default to 0]
 **_end** | **Integer**| &#x60;end&#x60; match number for subset of results to return (inclusive). | [optional] [default to 999]

### Return type

[**EventScheduleHybridModelVersion2**](EventScheduleHybridModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

