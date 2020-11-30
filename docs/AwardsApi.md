# FtcEventsClient::AwardsApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_awards_event_code_get**](AwardsApi.md#v20_season_awards_event_code_get) | **GET** /v2.0/{season}/awards/{eventCode} | Event Awards
[**v20_season_awards_event_code_team_number_get**](AwardsApi.md#v20_season_awards_event_code_team_number_get) | **GET** /v2.0/{season}/awards/{eventCode}/{teamNumber} | Event Awards
[**v20_season_awards_list_get**](AwardsApi.md#v20_season_awards_list_get) | **GET** /v2.0/{season}/awards/list | Award Listings
[**v20_season_awards_team_number_get**](AwardsApi.md#v20_season_awards_team_number_get) | **GET** /v2.0/{season}/awards/{teamNumber} | Event Awards



## v20_season_awards_event_code_get

> AwardsModel v20_season_awards_event_code_get(season, event_code, opts)

Event Awards

The event awards API returns details about awards presented at a particular event in a particular season. Return values may contain either `teamNumber` or `person` values, and if the winner was a `person`, and that person is from a team, the `teamNumber` value *might* be set with their `teamNumber`. You must specify either an `eventCode` or a `teamNumber` or both. If you specify the `teamNumber` parameter, you will receive only awards where the team was listed as the winner, regardless of whether or not the `person` field is `null` or empty. If you specify only the `eventCode` field, you will receive all award listings for the requested event. If you specify both, you will receive all awards won by the `teamNumber` at the `eventCode`.

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

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits
event_code = '' # String | Case insensitive alphanumeric `eventCode` of the event from which the awards are requested.
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
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the award listings are requested. Must be 4 digits | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the awards are requested. | [default to &#39;&#39;]
 **team_number** | **Integer**| &#x60;teamNumber&#x60; to search for within the results. | [optional] [default to 0]

### Return type

[**AwardsModel**](AwardsModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## v20_season_awards_event_code_team_number_get

> AwardsModel v20_season_awards_event_code_team_number_get(season, event_code, team_number)

Event Awards

The event awards API returns details about awards presented at a particular event in a particular season. Return values may contain either `teamNumber` or `person` values, and if the winner was a `person`, and that person is from a team, the `teamNumber` value *might* be set with their `teamNumber`. You must specify either an `eventCode` or a `teamNumber` or both. If you specify the `teamNumber` parameter, you will receive only awards where the team was listed as the winner, regardless of whether or not the `person` field is `null` or empty. If you specify only the `eventCode` field, you will receive all award listings for the requested event. If you specify both, you will receive all awards won by the `teamNumber` at the `eventCode`.

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

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits
event_code = '' # String | Case insensitive alphanumeric `eventCode` of the event from which the awards are requested.
team_number = 0 # Integer | `teamNumber` to search for within the results.

begin
  #Event Awards
  result = api_instance.v20_season_awards_event_code_team_number_get(season, event_code, team_number)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AwardsApi->v20_season_awards_event_code_team_number_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the award listings are requested. Must be 4 digits | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the awards are requested. | [default to &#39;&#39;]
 **team_number** | **Integer**| &#x60;teamNumber&#x60; to search for within the results. | [default to 0]

### Return type

[**AwardsModel**](AwardsModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## v20_season_awards_list_get

> SeasonAwardListingsModel v20_season_awards_list_get(season)

Award Listings

The award listings API returns a listing of the various awards that can be distributed in the requested season. This is especially useful in order to avoid having to use the name field of the event awards API to know which award was won. Instead the awardId field can be matched between the two APIs.

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

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits

begin
  #Award Listings
  result = api_instance.v20_season_awards_list_get(season)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AwardsApi->v20_season_awards_list_get: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the award listings are requested. Must be 4 digits | 

### Return type

[**SeasonAwardListingsModel**](SeasonAwardListingsModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## v20_season_awards_team_number_get

> AwardsModel v20_season_awards_team_number_get(season, team_number, opts)

Event Awards

The event awards API returns details about awards presented at a particular event in a particular season. Return values may contain either `teamNumber` or `person` values, and if the winner was a `person`, and that person is from a team, the `teamNumber` value *might* be set with their `teamNumber`. You must specify either an `eventCode` or a `teamNumber` or both. If you specify the `teamNumber` parameter, you will receive only awards where the team was listed as the winner, regardless of whether or not the `person` field is `null` or empty. If you specify only the `eventCode` field, you will receive all award listings for the requested event. If you specify both, you will receive all awards won by the `teamNumber` at the `eventCode`.

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

api_instance = FtcEventsClient::AwardsApi.new
season = 56 # Integer | Numeric year of the event from which the award listings are requested. Must be 4 digits
team_number = 0 # Integer | `teamNumber` to search for within the results.
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
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the award listings are requested. Must be 4 digits | 
 **team_number** | **Integer**| &#x60;teamNumber&#x60; to search for within the results. | [default to 0]
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the awards are requested. | [optional] [default to &#39;&#39;]

### Return type

[**AwardsModel**](AwardsModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

