# FtcEventsClient::AdvancementSourceModel

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**advanced_from** | **String** | The event code of the event this team advanced from. Null if unknown. | [optional] 
**advanced_from_region** | **String** | The region code of the region this team advanced from. Null if target event is a region-level event. | [optional] 
**slots** | **Integer** | The number of teams that advanced from the source event. | [optional] 
**advancement** | [**Array&lt;AdvancementSlot&gt;**](AdvancementSlot.md) | The ordered list of advancement criteria and teams that met them. Null if the event is unpublished. | [optional] 

