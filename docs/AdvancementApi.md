# FtcEventsClient::AdvancementApi

All URIs are relative to *http://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_advancement_event_code_get**](AdvancementApi.md#v20_season_advancement_event_code_get) | **GET** /v2.0/{season}/advancement/{eventCode} | Event Advancement
[**v20_season_advancement_event_code_source_get**](AdvancementApi.md#v20_season_advancement_event_code_source_get) | **GET** /v2.0/{season}/advancement/{eventCode}/source | Advancement Source

# **v20_season_advancement_event_code_get**
> AdvancementModel v20_season_advancement_event_code_get(season, event_code, opts)

Event Advancement

The event advancement endpoint returns details about teams advancing from a particular event in a particular season.

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

api_instance = FtcEventsClient::AdvancementApi.new
season = 56 # Integer | Numeric year of the event from which the event advancement is requested. Must be 4 digits > 2022
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event from which the advancement results are requested. Must be at least 3 characters.
opts = { 
  exclude_skipped: true # BOOLEAN | `excludeSkipped=true` to exclude skipped advancement slots. Slots are skipped if no team meets the criteria, the team has already advanced, or the team was ineligible.
}

begin
  #Event Advancement
  result = api_instance.v20_season_advancement_event_code_get(season, event_code, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AdvancementApi->v20_season_advancement_event_code_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the event advancement is requested. Must be 4 digits &gt; 2022 | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the advancement results are requested. Must be at least 3 characters. | 
 **exclude_skipped** | **BOOLEAN**| &#x60;excludeSkipped&#x3D;true&#x60; to exclude skipped advancement slots. Slots are skipped if no team meets the criteria, the team has already advanced, or the team was ineligible. | [optional] 

### Return type

[**AdvancementModel**](AdvancementModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **v20_season_advancement_event_code_source_get**
> Array&lt;AdvancementSourceModel&gt; v20_season_advancement_event_code_source_get(season, event_code)

Advancement Source

The advancement source API returns details about where teams advanced to a specified event from.

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

api_instance = FtcEventsClient::AdvancementApi.new
season = 56 # Integer | Numeric year of the event from which the advancement is requested. Must be 4 digits >= 2022
event_code = 'event_code_example' # String | Case insensitive alphanumeric `eventCode` of the event for which teams advanced to. Must be at least 3 characters.


begin
  #Advancement Source
  result = api_instance.v20_season_advancement_event_code_source_get(season, event_code)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling AdvancementApi->v20_season_advancement_event_code_source_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year of the event from which the advancement is requested. Must be 4 digits &gt;&#x3D; 2022 | 
 **event_code** | **String**| Case insensitive alphanumeric &#x60;eventCode&#x60; of the event for which teams advanced to. Must be at least 3 characters. | 

### Return type

[**Array&lt;AdvancementSourceModel&gt;**](AdvancementSourceModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



