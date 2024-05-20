# FtcEventsClient::MatchScoresModelMatchScoresOneOf

## Class instance methods

### `openapi_one_of`

Returns the list of classes defined in oneOf.

#### Example

```ruby
require 'ftc_events_client'

FtcEventsClient::MatchScoresModelMatchScoresOneOf.openapi_one_of
# =>
# [
#   :'ScoreDetailModel2019',
#   :'ScoreDetailModel2020',
#   :'ScoreDetailModel2021',
#   :'ScoreDetailModelSinglePlayer2020',
#   :'ScoreDetailModelSinglePlayer2021'
# ]
```

### build

Find the appropriate object from the `openapi_one_of` list and casts the data into it.

#### Example

```ruby
require 'ftc_events_client'

FtcEventsClient::MatchScoresModelMatchScoresOneOf.build(data)
# => #<ScoreDetailModel2019:0x00007fdd4aab02a0>

FtcEventsClient::MatchScoresModelMatchScoresOneOf.build(data_that_doesnt_match)
# => nil
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| **data** | **Mixed** | data to be matched against the list of oneOf items |

#### Return type

- `ScoreDetailModel2019`
- `ScoreDetailModel2020`
- `ScoreDetailModel2021`
- `ScoreDetailModelSinglePlayer2020`
- `ScoreDetailModelSinglePlayer2021`
- `nil` (if no type matches)

