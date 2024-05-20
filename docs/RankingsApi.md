# FtcEventsClient::RankingsApi

All URIs are relative to *http://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_rankings_event_code_get**](RankingsApi.md#v20_season_rankings_event_code_get) | **GET** /v2.0/{season}/rankings/{eventCode} | Event Rankings

# **v20_season_rankings_event_code_get**
> EventRankingsModel v20_season_rankings_event_code_get(season, event_code, opts)

Event Rankings

The rankings API returns team ranking detail from a particular event in a particular season. Optionally, the `top` parameter can be added to the query string to request a subset of the rankings based on the highest ranked teams at the time of the request. Alternately, you can specify the `teamNumber` parameter to retrieve the ranking on one specific team. You cannot specify both a `top` and `teamNumber` in the same call.

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
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the rankings are requested. Must be 4 digits | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the rankings are requested. Must be at least 3 characters. | 
 **team_number** | **Integer**| Team number of the team whose ranking is requested. | [optional] [default to 0]
 **top** | **Integer**| number of requested &#x60;top&#x60; ranked teams to return in result. | [optional] [default to 0]

### Return type

[**EventRankingsModel**](EventRankingsModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



