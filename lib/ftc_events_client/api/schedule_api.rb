=begin
#FTC Events API

#FTC Events API is a service to return relevant information about the _FIRST_ Tech Challenge (FTC). Information is made available from events operating around the world  Information is currently made available after the conclusion of the tournament.  The API will provide data as soon as it has synced, and we do not add any artificial delays.  ## Documentation Notes  ### Timezones  All times are listed in the local time to the event venue. HTTP-date values will show their timezone.  ### Query Parameters  If you specify a parameter, but no value for that parameter, it will be ignored. For example, if you request `URL?teamNumber=` the `teamNumber` parameter would be ignored.  For all APIs that accept a query string in addition to the base URI, the order of parameters do not matter, but the name shown in the documentation must match exactly, as does the associated value format as described in details.  For response codes that are not HTTP 200 (OK), the documentation will show a body message that represents a possible response value. While the \"title\" of the HTTP Status Code will match those shown in the response codes documentation section exactly, the body of the response will be a more detailed explanation of why that status code is being returned and may not always be exactly as shown in the examples.  ### Experimenting with the API  This documentation is rendered at both [api-docs](https://ftc-events.firstinspires.org/api-docs) and [try-it-out](https://ftc-events.firstinspires.org/try-it-out).  [api-docs](https://ftc-events.firstinspires.org/api-docs) has a three panel, easy to read layout, while [try-it-out](https://ftc-events.firstinspires.org/try-it-out) has a feature that allows you try out endpoints from within the page.  Additionally, the Open API Json is availabe at [Open API](https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json).  This can be imported into a tool such as [Postman](https://www.postman.com) for experimentation as well.   ### Last-Modified, FMS-OnlyModifiedSince, and If-Modified-Since Headers The FTC Events API utilizes the `Last-Modified` and `If-Modified-Since` Headers to communicate with consumers regarding the age of the data they are requesting. With a couple of exceptions, all calls will return a `Last-Modified` Header set with the time at which the data at that endpoint was last modified. The Header will always be set in the HTTP-date format, as described in the HTTP Protocol. There are two exceptions: the `Last-Modified` Header is not set if the endpoint returns no results (such as a request for a schedule with no matches).  Consumers should keep track of the `Last-Modified` Header, and return it on subsequent calls to the same endpoint as the If-Modified-Since. The server will recognize this request, and will only return a result if the data has been modified since the last request. If no changes have been made, an HTTP 304 will be returned. If data has been modified, ALL data on that call will be returned (for \"only modified\" data, see below).  The FTC Events API also allows a custom header used to filter the return data to a specific subset. This is done by specifying a `FMS-OnlyModifiedSince` header with each call. As with the `If-Modified-Since` header, consumers should keep track of the Last-Modified Header, and return it on subsequent calls to the same endpoint as the `FMS-OnlyModifiedSince` Header. The server will recognize this request, and will only return a result if the data has been modified since the last request, and, if returned, the data will only be those portions modified since the included date. If no changes, have been made, an HTTP 304 will be returned. Using this method, the server and consumer save processing time by only receiving modified data that is in need of update on the consumer side.  If the Headers are improperly passed (such as the wrong Day of Week for the matching date, or a date in the future), the endpoint will simply ignore the Header and return all results. If both headers are specified, the request will be denied.  ## Response Codes  The FTC Events API HTTP Status Codes correspond with the [common codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html), but occasionally with different \"titles\". The \"title\" used by the API is shown next to each of the below possible response HTTP Status Codes. Throughout the documentation, Apiary may automatically show the common \"title\" in example returns (like \"Not Found\" for 404) but on the production server, the \"title\" will instead match those listed below.  ### HTTP 200 - \"OK\" The request has succeeded. An entity corresponding to the requested resource is sent in the response. This will be returned as the HTTP Status Code for all request that succeed, even if the body is empty (such as an event that has no rankings, but with a valid season and event code were used)  ### HTTP 304 - \"Not Modified\" When utilizing a Header that allows filtered data returns, such as `If-Modified-Since`, this response indicates that no data meets the request.  ### HTTP 400 - \"Invalid Season Requested\"/\"Malformed Parameter Format In Request\"/\"Missing Parameter In Request\"/\"Invalid API Version Requested\": The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications. Specifically for this API, a 400 response indicates that the requested URI matches with a valid API, but one or more required parameter was malformed or invalid. Examples include an event code that is too short or team number that contains a letter.  ### HTTP 401 - \"Unauthorized\" All requests against the API require authentication via a valid user token. Failing to provide one, or providing an invalid one, will warrant a 401 response. The client MAY repeat the request with a suitable Authorization header field.  ### HTTP 404 - \"Invalid Event Requested\" Even though the 404 code usually indicates any not found status, a 404 will only be issued in this API when an event cannot be found for the requested season and event code. If the request didn't match a valid API or there were malformed parameters, the response would not receive a 404 but rather a 400 or 501. If this HTTP code is received, the season was a valid season and the event code matched the acceptable style of an event code, but there were no records of an event matching the combination of that season and event code. For example, HTTP 404 would be issued when the event had a different code in the requested season (the codes can change year to year based on event location).  ### HTTP 500 - \"Internal Server Error\" The server encountered an unexpected condition which prevented it from fulfilling the request. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ### HTTP 501 - \"Request Did Not Match Any Current API Pattern\" The server does not support the functionality required to fulfill the request. Specifically, the request pattern did not match any of the possible APIs, and thus processing was discontinued. This code is also issued when too many optional parameters were included in a single request and fulfilling it would make the result confusing or misleading. Each API will specify which parameters or combination of parameters can be used at the same time.  ### HTTP 503 - \"Service Unavailable\" The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a `Retry-After` header. This code will not always appear, sometimes the server may outright refuse the connection instead. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ## Authorization In order to make calls against the FTC Events API, you must include an HTTP Header called `Authorization` with the value set as specified below. If a request is made without this header, processing stops and an HTTP 401 is issued. All `Authorization` headers follow the same format:  ``` Authorization: Basic 000000000000000000000000000000000000000000000000000000000000 ```  Where the Zeros are replaced by your Token. The Token can be formed by taking your username and your AuthorizationKey and adding a colon. For example, if your username is `sampleuser` and your AuthorizationKey is `7eaa6338-a097-4221-ac04-b6120fcc4d49` you would have this string:  ``` sampleuser:7eaa6338-a097-4221-ac04-b6120fcc4d49 ```  This string must then be encoded using Base64 Encoded to form the Token, which will be the same length as the example above, but include letters and numbers. For our example, we would have:  ``` c2FtcGxldXNlcjo3ZWFhNjMzOC1hMDk3LTQyMjEtYWMwNC1iNjEyMGZjYzRkNDk= ```  Most API client libraries can handle computing the authorization header using a username and password for you  NOTICE: Publicly distributing an application, code snippet, etc, that has your username and token in it, encoded or not, WILL result in your token being blocked from the API. Each user should apply for their own token.  If you wish to acquire a token for your development, you may do so by requesting a token through our automated system on this website. 

OpenAPI spec version: v2.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.52
=end

module FtcEventsClient
  class ScheduleApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Event Schedule
    # The schedule API returns the match schedule for the desired tournament level of a particular event in a particular season. You must also specify a `tournamentLevel` from which to return the results. Alternately, you can specify a `teamNumber` to filter the results to only those in which a particular team is participating. There is no validation that the `teamNumber` you request is actually competing at the event, if they are not, the response will be empty. You can also specify the parameters together, but cannot make a request without at least one of the two.
    # @param season Numeric year of the event from which the schedule is requested. Must be 4 digits
    # @param event_code Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the schedule are requested. Must be at least 3 characters.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :tournament_level Required tournamentLevel of desired score details. (default to 0)
    # @option opts [Integer] :team_number &#x60;teamNumber&#x60; to search for within the schedule. Only returns matches in which the requested team participated. (default to 0)
    # @option opts [Integer] :start &#x60;start&#x60; match number for subset of results to return (inclusive). (default to 0)
    # @option opts [Integer] :_end &#x60;end&#x60; match number for subset of results to return (inclusive). (default to 999)
    # @return [EventScheduleModelVersion2]
    def v20_season_schedule_event_code_get(season, event_code, opts = {})
      data, _status_code, _headers = v20_season_schedule_event_code_get_with_http_info(season, event_code, opts)
      data
    end

    # Event Schedule
    # The schedule API returns the match schedule for the desired tournament level of a particular event in a particular season. You must also specify a &#x60;tournamentLevel&#x60; from which to return the results. Alternately, you can specify a &#x60;teamNumber&#x60; to filter the results to only those in which a particular team is participating. There is no validation that the &#x60;teamNumber&#x60; you request is actually competing at the event, if they are not, the response will be empty. You can also specify the parameters together, but cannot make a request without at least one of the two.
    # @param season Numeric year of the event from which the schedule is requested. Must be 4 digits
    # @param event_code Case insensitive alphanumeric &#x60;eventCode&#x60; of the event from which the schedule are requested. Must be at least 3 characters.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :tournament_level Required tournamentLevel of desired score details.
    # @option opts [Integer] :team_number &#x60;teamNumber&#x60; to search for within the schedule. Only returns matches in which the requested team participated.
    # @option opts [Integer] :start &#x60;start&#x60; match number for subset of results to return (inclusive).
    # @option opts [Integer] :_end &#x60;end&#x60; match number for subset of results to return (inclusive).
    # @return [Array<(EventScheduleModelVersion2, Integer, Hash)>] EventScheduleModelVersion2 data, response status code and response headers
    def v20_season_schedule_event_code_get_with_http_info(season, event_code, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ScheduleApi.v20_season_schedule_event_code_get ...'
      end
      # verify the required parameter 'season' is set
      if @api_client.config.client_side_validation && season.nil?
        fail ArgumentError, "Missing the required parameter 'season' when calling ScheduleApi.v20_season_schedule_event_code_get"
      end
      # verify the required parameter 'event_code' is set
      if @api_client.config.client_side_validation && event_code.nil?
        fail ArgumentError, "Missing the required parameter 'event_code' when calling ScheduleApi.v20_season_schedule_event_code_get"
      end
      if @api_client.config.client_side_validation && opts[:'tournament_level'] && !['qual', 'playoff'].include?(opts[:'tournament_level'])
        fail ArgumentError, 'invalid value for "tournament_level", must be one of qual, playoff'
      end
      # resource path
      local_var_path = '/v2.0/{season}/schedule/{eventCode}'.sub('{' + 'season' + '}', season.to_s).sub('{' + 'eventCode' + '}', event_code.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'tournamentLevel'] = opts[:'tournament_level'] if !opts[:'tournament_level'].nil?
      query_params[:'teamNumber'] = opts[:'team_number'] if !opts[:'team_number'].nil?
      query_params[:'start'] = opts[:'start'] if !opts[:'start'].nil?
      query_params[:'end'] = opts[:'_end'] if !opts[:'_end'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'EventScheduleModelVersion2' 

      auth_names = opts[:auth_names] || ['basic']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ScheduleApi#v20_season_schedule_event_code_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Hybrid Schedule
    # The schedule API returns the match schedule for the desired tournament level of a particular event in a particular season in the hybrid format. When a match has been played, the match result related details will be filled. When a match has not yet happened, match result related fields will be null. All parameters, except start and end, are required for the hybrid schedule.
    # @param season Numeric year of the event from which the hybrid schedule is requested. Must be 4 digits
    # @param event_code Case insensitive alphanumeric eventCode of the event from which the hybrid schedule is requested. Must be at least 3 characters.
    # @param tournament_level Required tournamentLevel of desired score details.
    # @param [Hash] opts the optional parameters
    # @option opts [Integer] :start &#x60;start&#x60; match number for subset of results to return (inclusive). (default to 0)
    # @option opts [Integer] :_end &#x60;end&#x60; match number for subset of results to return (inclusive). (default to 999)
    # @return [EventScheduleHybridModelVersion2]
    def v20_season_schedule_event_code_tournament_level_hybrid_get(season, event_code, tournament_level, opts = {})
      data, _status_code, _headers = v20_season_schedule_event_code_tournament_level_hybrid_get_with_http_info(season, event_code, tournament_level, opts)
      data
    end

    # Hybrid Schedule
    # The schedule API returns the match schedule for the desired tournament level of a particular event in a particular season in the hybrid format. When a match has been played, the match result related details will be filled. When a match has not yet happened, match result related fields will be null. All parameters, except start and end, are required for the hybrid schedule.
    # @param season Numeric year of the event from which the hybrid schedule is requested. Must be 4 digits
    # @param event_code Case insensitive alphanumeric eventCode of the event from which the hybrid schedule is requested. Must be at least 3 characters.
    # @param tournament_level Required tournamentLevel of desired score details.
    # @param [Hash] opts the optional parameters
    # @option opts [Integer] :start &#x60;start&#x60; match number for subset of results to return (inclusive).
    # @option opts [Integer] :_end &#x60;end&#x60; match number for subset of results to return (inclusive).
    # @return [Array<(EventScheduleHybridModelVersion2, Integer, Hash)>] EventScheduleHybridModelVersion2 data, response status code and response headers
    def v20_season_schedule_event_code_tournament_level_hybrid_get_with_http_info(season, event_code, tournament_level, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ScheduleApi.v20_season_schedule_event_code_tournament_level_hybrid_get ...'
      end
      # verify the required parameter 'season' is set
      if @api_client.config.client_side_validation && season.nil?
        fail ArgumentError, "Missing the required parameter 'season' when calling ScheduleApi.v20_season_schedule_event_code_tournament_level_hybrid_get"
      end
      # verify the required parameter 'event_code' is set
      if @api_client.config.client_side_validation && event_code.nil?
        fail ArgumentError, "Missing the required parameter 'event_code' when calling ScheduleApi.v20_season_schedule_event_code_tournament_level_hybrid_get"
      end
      # verify the required parameter 'tournament_level' is set
      if @api_client.config.client_side_validation && tournament_level.nil?
        fail ArgumentError, "Missing the required parameter 'tournament_level' when calling ScheduleApi.v20_season_schedule_event_code_tournament_level_hybrid_get"
      end
      # verify enum value
      if @api_client.config.client_side_validation && !['qual', 'playoff'].include?(tournament_level)
        fail ArgumentError, "invalid value for 'tournament_level', must be one of qual, playoff"
      end
      # resource path
      local_var_path = '/v2.0/{season}/schedule/{eventCode}/{tournamentLevel}/hybrid'.sub('{' + 'season' + '}', season.to_s).sub('{' + 'eventCode' + '}', event_code.to_s).sub('{' + 'tournamentLevel' + '}', tournament_level.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'start'] = opts[:'start'] if !opts[:'start'].nil?
      query_params[:'end'] = opts[:'_end'] if !opts[:'_end'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'EventScheduleHybridModelVersion2' 

      auth_names = opts[:auth_names] || ['basic']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ScheduleApi#v20_season_schedule_event_code_tournament_level_hybrid_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
