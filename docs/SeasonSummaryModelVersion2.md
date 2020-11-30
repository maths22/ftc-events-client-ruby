# FtcEventsClient::SeasonSummaryModelVersion2

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**event_count** | **Integer** |  | [optional] 
**game_name** | **String** |  | [optional] 
**kickoff** | **DateTime** |  | [optional] 
**rookie_start** | **Integer** |  | [optional] 
**team_count** | **Integer** |  | [optional] 
**frc_championships** | [**Array&lt;SeasonSummaryModelChampionship&gt;**](SeasonSummaryModelChampionship.md) |  | [optional] 

## Code Sample

```ruby
require 'FtcEventsClient'

instance = FtcEventsClient::SeasonSummaryModelVersion2.new(event_count: null,
                                 game_name: null,
                                 kickoff: null,
                                 rookie_start: null,
                                 team_count: null,
                                 frc_championships: null)
```


