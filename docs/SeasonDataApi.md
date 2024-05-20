# FtcEventsClient::SeasonDataApi

All URIs are relative to *http://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_events_get**](SeasonDataApi.md#v20_season_events_get) | **GET** /v2.0/{season}/events | Event Listings
[**v20_season_get**](SeasonDataApi.md#v20_season_get) | **GET** /v2.0/{season} | Season Summary
[**v20_season_teams_get**](SeasonDataApi.md#v20_season_teams_get) | **GET** /v2.0/{season}/teams | Team Listings

# **v20_season_events_get**
> SeasonEventListingsModelVersion2 v20_season_events_get(season, opts)

Event Listings

The event listings API returns all FTC official regional events in a particular season. You can specify an `eventCode` if you would only like data about one specific event. If you specify an `eventCode` you cannot specify any other optional parameters. Alternately, you can specify a `teamNumber` to retrieve only the listings of events being attended by the particular team. If you specify a `teamNumber` you cannot specify an `eventCode`.  The response for event listings contains a special field called divisionCode. For example, the FIRST Championship contains two Divisions. As an example of a response, the event listings for a Division will have a divisionCode that matches the FIRST Championship event code (as they are divisions of that event). This allows you to see the full structure of events, and how they relate to each other.

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
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year from which the event listings are requested. Must be 4 digits | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event about which details are requested. | [optional] [default to 0]
 **team_number** | **Integer**| Numeric &#x60;teamNumber&#x60; of the team from which the attending event listings are requested. | [optional] [default to 0]

### Return type

[**SeasonEventListingsModelVersion2**](SeasonEventListingsModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **v20_season_get**
> SeasonSummaryModelVersion2 v20_season_get(season)

Season Summary

The season summary API returns a high level glance of a particular FTC season.

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

api_instance = FtcEventsClient::SeasonDataApi.new
season = 56 # Integer | Numeric year of the event from which the season summary is requested. Must be 4 digits.


begin
  #Season Summary
  result = api_instance.v20_season_get(season)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling SeasonDataApi->v20_season_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the season summary is requested. Must be 4 digits. | 

### Return type

[**SeasonSummaryModelVersion2**](SeasonSummaryModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **v20_season_teams_get**
> SeasonTeamListingsModelVersion2 v20_season_teams_get(season, opts)

Team Listings

The team listings API returns all FTC official teams in a particular season. If specified, the `teamNumber` parameter will return only one result with the details of the requested `teamNumber`. Alternately, the `eventCode` parameter allows sorting of the team list to only those teams attending a particular event in the particular season. If you specify a teamNumber parameter, you cannot additionally specify an `eventCode` and/or `state` in the same request, or you will receive an HTTP 501. If you specify the `state` parameter, it should be the full legal name of the US state or international state/prov, such as New Hampshire or Ontario. Values on this endpoint are \"pass through\" values from the TIMS registration system. As such, if the team does not specify a value for a field, it may be presented in the API as null.

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

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year from which the team listings are requested. Must be 4 digits. | 
 **team_number** | **Integer**| Numeric &#x60;teamNumber&#x60; of the team about which information is requested. Must be 1 to 5 digits. | [optional] [default to 0]
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which details are requested. | [optional] [default to 0]
 **state** | **String**| Full legal name of the US state or international state/prov | [optional] 
 **page** | **Integer**| Numeric page of results to return. | [optional] [default to 1]

### Return type

[**SeasonTeamListingsModelVersion2**](SeasonTeamListingsModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



