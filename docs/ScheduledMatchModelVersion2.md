# FtcEventsClient::ScheduledMatchModelVersion2

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**description** | **String** |  | [optional] 
**field** | **String** |  | [optional] 
**tournament_level** | **String** |  | [optional] 
**start_time** | **DateTime** |  | [optional] 
**series** | **Integer** |  | [optional] 
**match_number** | **Integer** |  | [optional] 
**teams** | [**Array&lt;ScheduledMatchTeamModelVersion2&gt;**](ScheduledMatchTeamModelVersion2.md) |  | [optional] 
**modified_on** | **DateTime** |  | [optional] 

## Code Sample

```ruby
require 'FtcEventsClient'

instance = FtcEventsClient::ScheduledMatchModelVersion2.new(description: null,
                                 field: null,
                                 tournament_level: null,
                                 start_time: null,
                                 series: null,
                                 match_number: null,
                                 teams: null,
                                 modified_on: null)
```


