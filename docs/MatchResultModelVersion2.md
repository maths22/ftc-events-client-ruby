# FtcEventsClient::MatchResultModelVersion2

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**actual_start_time** | **DateTime** |  | [optional] 
**description** | **String** |  | [optional] 
**tournament_level** | **String** |  | [optional] 
**series** | **Integer** |  | [optional] 
**match_number** | **Integer** |  | [optional] 
**score_red_final** | **Integer** |  | [optional] 
**score_red_foul** | **Integer** |  | [optional] 
**score_red_auto** | **Integer** |  | [optional] 
**score_blue_final** | **Integer** |  | [optional] 
**score_blue_foul** | **Integer** |  | [optional] 
**score_blue_auto** | **Integer** |  | [optional] 
**post_result_time** | **DateTime** |  | [optional] 
**teams** | [**Array&lt;MatchResultTeamModelVersion2&gt;**](MatchResultTeamModelVersion2.md) |  | [optional] 
**modified_on** | **DateTime** |  | [optional] 

## Code Sample

```ruby
require 'FtcEventsClient'

instance = FtcEventsClient::MatchResultModelVersion2.new(actual_start_time: null,
                                 description: null,
                                 tournament_level: null,
                                 series: null,
                                 match_number: null,
                                 score_red_final: null,
                                 score_red_foul: null,
                                 score_red_auto: null,
                                 score_blue_final: null,
                                 score_blue_foul: null,
                                 score_blue_auto: null,
                                 post_result_time: null,
                                 teams: null,
                                 modified_on: null)
```


