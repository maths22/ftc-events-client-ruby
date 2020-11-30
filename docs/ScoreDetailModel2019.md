# FtcEventsClient::ScoreDetailModel2019

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**match_level** | [**TournamentLevel**](TournamentLevel.md) |  | [optional] 
**match_number** | **Integer** |  | [optional] 
**alliances** | [**Array&lt;ScoreDetailModelAlliance2019&gt;**](ScoreDetailModelAlliance2019.md) |  | [optional] 

## Code Sample

```ruby
require 'FtcEventsClient'

instance = FtcEventsClient::ScoreDetailModel2019.new(match_level: null,
                                 match_number: null,
                                 alliances: null)
```


