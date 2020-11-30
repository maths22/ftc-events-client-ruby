# FtcEventsClient::ScheduleHybridModelVersion2

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**description** | **String** |  | [optional] 
**tournament_level** | **String** |  | [optional] 
**series** | **Integer** |  | [optional] 
**match_number** | **Integer** |  | [optional] 
**start_time** | **DateTime** |  | [optional] 
**actual_start_time** | **DateTime** |  | [optional] 
**post_result_time** | **DateTime** |  | [optional] 
**score_red_final** | **Integer** |  | [optional] 
**score_red_foul** | **Integer** |  | [optional] 
**score_red_auto** | **Integer** |  | [optional] 
**score_blue_final** | **Integer** |  | [optional] 
**score_blue_foul** | **Integer** |  | [optional] 
**score_blue_auto** | **Integer** |  | [optional] 
**teams** | [**Array&lt;ScheduleHybridModelTeamVersion2&gt;**](ScheduleHybridModelTeamVersion2.md) |  | [optional] 

## Code Sample

```ruby
require 'FtcEventsClient'

instance = FtcEventsClient::ScheduleHybridModelVersion2.new(description: null,
                                 tournament_level: null,
                                 series: null,
                                 match_number: null,
                                 start_time: null,
                                 actual_start_time: null,
                                 post_result_time: null,
                                 score_red_final: null,
                                 score_red_foul: null,
                                 score_red_auto: null,
                                 score_blue_final: null,
                                 score_blue_foul: null,
                                 score_blue_auto: null,
                                 teams: null)
```


