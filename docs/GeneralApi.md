# FtcEventsClient::GeneralApi

All URIs are relative to *http://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_get**](GeneralApi.md#v20_get) | **GET** /v2.0 | API Index

# **v20_get**
> ApiIndexModel v20_get

API Index

Root level call with no parameters.

### Example
```ruby
# load the gem
require 'ftc_events_client'

api_instance = FtcEventsClient::GeneralApi.new

begin
  #API Index
  result = api_instance.v20_get
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling GeneralApi->v20_get: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiIndexModel**](ApiIndexModel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



