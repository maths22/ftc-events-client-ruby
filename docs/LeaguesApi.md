# FtcEventsClient::LeaguesApi

All URIs are relative to *https://ftc-api.firstinspires.org*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v20_season_leagues_get**](LeaguesApi.md#v20_season_leagues_get) | **GET** /v2.0/{season}/leagues | League Listings
[**v20_season_leagues_members_region_code_league_code_get**](LeaguesApi.md#v20_season_leagues_members_region_code_league_code_get) | **GET** /v2.0/{season}/leagues/members/{regionCode}/{leagueCode} | League Membership
[**v20_season_leagues_rankings_region_code_league_code_get**](LeaguesApi.md#v20_season_leagues_rankings_region_code_league_code_get) | **GET** /v2.0/{season}/leagues/rankings/{regionCode}/{leagueCode} | League Rankings

# **v20_season_leagues_get**
> SeasonLeagueListingsModelVersion2 v20_season_leagues_get(season, opts)

League Listings

The league listings API returns all FTC leagues in a particular season. You can specify a `regionCode` to filter to leagues within a particular region. To filter to a specific league, supply both a `regionCode` and a `leagueCode`. The returned objects have a `parentLeagueCode` field, which indicates the league is a child league if not null and provides the code of the parent league. The `regionCode` of the parent league will always match the child.

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

api_instance = FtcEventsClient::LeaguesApi.new
season = 56 # Integer | Numeric year from which the league listings are requested. Must be 4 digits
opts = { 
  region_code: 'region_code_example', # String | Case-sensitive alphanumeric `regionCode` of a region to filter for.
  league_code: 'league_code_example' # String | Case-sensitive alphanumeric `leagueCode` of the league within the specified region to query.
}

begin
  #League Listings
  result = api_instance.v20_season_leagues_get(season, opts)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling LeaguesApi->v20_season_leagues_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year from which the league listings are requested. Must be 4 digits | 
 **region_code** | **String**| Case-sensitive alphanumeric &#x60;regionCode&#x60; of a region to filter for. | [optional] 
 **league_code** | **String**| Case-sensitive alphanumeric &#x60;leagueCode&#x60; of the league within the specified region to query. | [optional] 

### Return type

[**SeasonLeagueListingsModelVersion2**](SeasonLeagueListingsModelVersion2.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **v20_season_leagues_members_region_code_league_code_get**
> LeagueMemberListModel v20_season_leagues_members_region_code_league_code_get(season, region_code, league_code)

League Membership

The league membership API returns the list of team numbers for the teams that are members of a particular league. Leagues are specified by a `regionCode` in combination with a `leagueCode`.

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

api_instance = FtcEventsClient::LeaguesApi.new
season = 56 # Integer | Numeric year. Must be 4 digits
region_code = 'region_code_example' # String | Case sensitive alphanumeric `regionCode` of the region the league belongs to.
league_code = 'league_code_example' # String | Case sensitive alphanumeric `leagueCode` of the league.


begin
  #League Membership
  result = api_instance.v20_season_leagues_members_region_code_league_code_get(season, region_code, league_code)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling LeaguesApi->v20_season_leagues_members_region_code_league_code_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year. Must be 4 digits | 
 **region_code** | **String**| Case sensitive alphanumeric &#x60;regionCode&#x60; of the region the league belongs to. | 
 **league_code** | **String**| Case sensitive alphanumeric &#x60;leagueCode&#x60; of the league. | 

### Return type

[**LeagueMemberListModel**](LeagueMemberListModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **v20_season_leagues_rankings_region_code_league_code_get**
> EventRankingsModel v20_season_leagues_rankings_region_code_league_code_get(season, region_code, league_code)

League Rankings

The league rankings API returns team ranking detail from a particular league in a particular season. League rankings are only the cumulative rankings from League Meets - they do not include performance at the League Tournament. To get League Tournament Rankings, use the Event Rankings endpoint.

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

api_instance = FtcEventsClient::LeaguesApi.new
season = 56 # Integer | Numeric year. Must be 4 digits
region_code = 'region_code_example' # String | Case sensitive alphanumeric `regionCode` of the region the league belongs to.
league_code = 'league_code_example' # String | Case sensitive alphanumeric `leagueCode` of the league.


begin
  #League Rankings
  result = api_instance.v20_season_leagues_rankings_region_code_league_code_get(season, region_code, league_code)
  p result
rescue FtcEventsClient::ApiError => e
  puts "Exception when calling LeaguesApi->v20_season_leagues_rankings_region_code_league_code_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **season** | **Integer**| Numeric year. Must be 4 digits | 
 **region_code** | **String**| Case sensitive alphanumeric &#x60;regionCode&#x60; of the region the league belongs to. | 
 **league_code** | **String**| Case sensitive alphanumeric &#x60;leagueCode&#x60; of the league. | 

### Return type

[**EventRankingsModel**](EventRankingsModel.md)

### Authorization

[basic](../README.md#basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



