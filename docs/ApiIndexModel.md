# FtcEventsClient::ApiIndexModel

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | api name | [optional] 
**api_version** | **String** | api version | [optional] 
**service_mainifest_name** | **String** |  | [optional] 
**service_mainifest_version** | **String** |  | [optional] 
**code_package_name** | **String** |  | [optional] 
**code_package_version** | **String** |  | [optional] 
**status** | **String** |  | [optional] 
**current_season** | **Integer** | current season in the eyes of FTC | [optional] 
**max_season** | **Integer** | max season that can be retrieved from the API/webpages | [optional] 

## Code Sample

```ruby
require 'FtcEventsClient'

instance = FtcEventsClient::ApiIndexModel.new(name: FIRST TECH CHALLENGE API,
                                 api_version: 2.0,
                                 service_mainifest_name: null,
                                 service_mainifest_version: null,
                                 code_package_name: null,
                                 code_package_version: null,
                                 status: null,
                                 current_season: 2020,
                                 max_season: 2020)
```


