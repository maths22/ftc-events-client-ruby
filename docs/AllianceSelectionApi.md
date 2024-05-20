# FtcEventsClient::AllianceSelectionApi

All URIs are relative to *https://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_alliances_event_code_get**](AllianceSelectionApi.md#v20_season_alliances_event_code_get) | **GET** /v2.0/{season}/alliances/{eventCode} | Event Alliances

# **v20_season_alliances_event_code_get**
> AllianceSelectionModelVersion2 v20_season_alliances_event_code_get(season, event_code)

Event Alliances

The alliances API returns details about alliance selection at a particular event in a particular season.

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
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the event alliances are requested. Must be 4 digits. | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the alliance selection results are requested. Must be at least 3 characters. | 

### Return type

[**AllianceSelectionModelVersion2**](AllianceSelectionModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



