# FtcEventsClient::AdvancementSlot

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**team** | **Integer** | The team number of the team earning this advancement slot. Null if no team meets the criteria. | [optional] 
**team_id** | **Integer** |  | [optional] 
**team_profile_id** | **Integer** |  | [optional] 
**display_team** | **String** | The display-friendly string representation of the number of the team earning this advancement slot. Null if no team meets the criteria. | [optional] 
**slot** | **Integer** | The number of the advancement criteria as shown in GM1 section 6.2. | [optional] 
**criteria** | **String** | String describing the advancement criteria as shown in GM1 section 6.2. | [optional] 
**status** | [**ApiAdvancementStatus**](ApiAdvancementStatus.md) |  | [optional] 

