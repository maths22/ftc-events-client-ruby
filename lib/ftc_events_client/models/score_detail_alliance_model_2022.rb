=begin
#FTC Events API

#FTC Events API is a service to return relevant information about the _FIRST_ Tech Challenge (FTC). Information is made available from events operating around the world  Information is currently made available after the conclusion of the tournament.  The API will provide data as soon as it has synced, and we do not add any artificial delays.  ## Documentation Notes  ### Timezones  All times are listed in the local time to the event venue. HTTP-date values will show their timezone.  ### Query Parameters  If you specify a parameter, but no value for that parameter, it will be ignored. For example, if you request `URL?teamNumber=` the `teamNumber` parameter would be ignored.  For all APIs that accept a query string in addition to the base URI, the order of parameters do not matter, but the name shown in the documentation must match exactly, as does the associated value format as described in details.  For response codes that are not HTTP 200 (OK), the documentation will show a body message that represents a possible response value. While the \"title\" of the HTTP Status Code will match those shown in the response codes documentation section exactly, the body of the response will be a more detailed explanation of why that status code is being returned and may not always be exactly as shown in the examples.  ### Experimenting with the API  This documentation is rendered at both [api-docs](https://ftc-events.firstinspires.org/api-docs) and [try-it-out](https://ftc-events.firstinspires.org/try-it-out).  [api-docs](https://ftc-events.firstinspires.org/api-docs) has a three panel, easy to read layout, while [try-it-out](https://ftc-events.firstinspires.org/try-it-out) has a feature that allows you try out endpoints from within the page.  Additionally, the Open API Json is availabe at [Open API](https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json).  This can be imported into a tool such as [Postman](https://www.postman.com) for experimentation as well.   ### Last-Modified, FMS-OnlyModifiedSince, and If-Modified-Since Headers The FTC Events API utilizes the `Last-Modified` and `If-Modified-Since` Headers to communicate with consumers regarding the age of the data they are requesting. With a couple of exceptions, all calls will return a `Last-Modified` Header set with the time at which the data at that endpoint was last modified. The Header will always be set in the HTTP-date format, as described in the HTTP Protocol. There are two exceptions: the `Last-Modified` Header is not set if the endpoint returns no results (such as a request for a schedule with no matches).  Consumers should keep track of the `Last-Modified` Header, and return it on subsequent calls to the same endpoint as the If-Modified-Since. The server will recognize this request, and will only return a result if the data has been modified since the last request. If no changes have been made, an HTTP 304 will be returned. If data has been modified, ALL data on that call will be returned (for \"only modified\" data, see below).  The FTC Events API also allows a custom header used to filter the return data to a specific subset. This is done by specifying a `FMS-OnlyModifiedSince` header with each call. As with the `If-Modified-Since` header, consumers should keep track of the Last-Modified Header, and return it on subsequent calls to the same endpoint as the `FMS-OnlyModifiedSince` Header. The server will recognize this request, and will only return a result if the data has been modified since the last request, and, if returned, the data will only be those portions modified since the included date. If no changes, have been made, an HTTP 304 will be returned. Using this method, the server and consumer save processing time by only receiving modified data that is in need of update on the consumer side.  If the Headers are improperly passed (such as the wrong Day of Week for the matching date, or a date in the future), the endpoint will simply ignore the Header and return all results. If both headers are specified, the request will be denied.  ## Response Codes  The FTC Events API HTTP Status Codes correspond with the [common codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html), but occasionally with different \"titles\". The \"title\" used by the API is shown next to each of the below possible response HTTP Status Codes. Throughout the documentation, Apiary may automatically show the common \"title\" in example returns (like \"Not Found\" for 404) but on the production server, the \"title\" will instead match those listed below.  ### HTTP 200 - \"OK\" The request has succeeded. An entity corresponding to the requested resource is sent in the response. This will be returned as the HTTP Status Code for all request that succeed, even if the body is empty (such as an event that has no rankings, but with a valid season and event code were used)  ### HTTP 304 - \"Not Modified\" When utilizing a Header that allows filtered data returns, such as `If-Modified-Since`, this response indicates that no data meets the request.  ### HTTP 400 - \"Invalid Season Requested\"/\"Malformed Parameter Format In Request\"/\"Missing Parameter In Request\"/\"Invalid API Version Requested\": The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications. Specifically for this API, a 400 response indicates that the requested URI matches with a valid API, but one or more required parameter was malformed or invalid. Examples include an event code that is too short or team number that contains a letter.  ### HTTP 401 - \"Unauthorized\" All requests against the API require authentication via a valid user token. Failing to provide one, or providing an invalid one, will warrant a 401 response. The client MAY repeat the request with a suitable Authorization header field.  ### HTTP 404 - \"Invalid Event Requested\" Even though the 404 code usually indicates any not found status, a 404 will only be issued in this API when an event cannot be found for the requested season and event code. If the request didn't match a valid API or there were malformed parameters, the response would not receive a 404 but rather a 400 or 501. If this HTTP code is received, the season was a valid season and the event code matched the acceptable style of an event code, but there were no records of an event matching the combination of that season and event code. For example, HTTP 404 would be issued when the event had a different code in the requested season (the codes can change year to year based on event location).  ### HTTP 500 - \"Internal Server Error\" The server encountered an unexpected condition which prevented it from fulfilling the request. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ### HTTP 501 - \"Request Did Not Match Any Current API Pattern\" The server does not support the functionality required to fulfill the request. Specifically, the request pattern did not match any of the possible APIs, and thus processing was discontinued. This code is also issued when too many optional parameters were included in a single request and fulfilling it would make the result confusing or misleading. Each API will specify which parameters or combination of parameters can be used at the same time.  ### HTTP 503 - \"Service Unavailable\" The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a `Retry-After` header. This code will not always appear, sometimes the server may outright refuse the connection instead. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ## Authorization In order to make calls against the FTC Events API, you must include an HTTP Header called `Authorization` with the value set as specified below. If a request is made without this header, processing stops and an HTTP 401 is issued. All `Authorization` headers follow the same format:  ``` Authorization: Basic 000000000000000000000000000000000000000000000000000000000000 ```  Where the Zeros are replaced by your Token. The Token can be formed by taking your username and your AuthorizationKey and adding a colon. For example, if your username is `sampleuser` and your AuthorizationKey is `7eaa6338-a097-4221-ac04-b6120fcc4d49` you would have this string:  ``` sampleuser:7eaa6338-a097-4221-ac04-b6120fcc4d49 ```  This string must then be encoded using Base64 Encoded to form the Token, which will be the same length as the example above, but include letters and numbers. For our example, we would have:  ``` c2FtcGxldXNlcjo3ZWFhNjMzOC1hMDk3LTQyMjEtYWMwNC1iNjEyMGZjYzRkNDk= ```  Most API client libraries can handle computing the authorization header using a username and password for you  NOTICE: Publicly distributing an application, code snippet, etc, that has your username and token in it, encoded or not, WILL result in your token being blocked from the API. Each user should apply for their own token.  If you wish to acquire a token for your development, you may do so by requesting a token through our automated system on this website. 

OpenAPI spec version: v2.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.52
=end

require 'date'

module FtcEventsClient
  class ScoreDetailAllianceModel2022
    attr_accessor :side_of_field

    attr_accessor :init_signal_sleeve1

    attr_accessor :init_signal_sleeve2

    attr_accessor :robot1_auto

    attr_accessor :robot2_auto

    attr_accessor :auto_terminal

    # Two dimensional array of lists of items scored on junctions in autonomous. [0,0] is the upper-left corner of the field as viewed from the audience side of the field (V5). The array is indexed by row, then column. (e.g [0,4] is in the upper right corner of the field (Z5).) Each junction is stored bottom up (index 0 is the bottom-most element on the field). MY_* elements belong to the alliance whose score object the element appears in, OTHER_* elements belong to the opposing alliance. (e.g in a set of scores for the red alliance, MY_CONE is a red cone and OTHER_CONE is a blue cone.) For a complete example, if red.autoJunctions[4][0][1] is OTHER_CONE, there is a blue cone in the bottom left cornerof the field (V1) on top of one other cone.
    attr_accessor :auto_junctions

    # Two dimensional array of lists of items scored on junctions in driver-controlled. [0,0] is the upper-left corner of the field as viewed from the audience side of the field (V5). The array is indexed by crow, then column. (e.g [0,4] is in the upper right corner of the field (Z5).) Each junction is stored bottom up (index 0 is the bottom-most element on the field). MY_* elements belong to the alliance whose score object the element appears in, OTHER_* elements belong to the opposing alliance. (e.g in a set of scores for the red alliance, MY_CONE is a red cone and OTHER_CONE is a blue cone.) *_R1_BEACON means the beacon scored by robot 1 on the corresponding alliance. For a complete example, if red.dcJunctions[4][0][1] is OTHER_CONE, there is a blue cone in the bottom left cornerof the field (V1) on top of one other cone.
    attr_accessor :dc_junctions

    # Number of Scored cones in the alliance-colored terminal on the side of the field closest to the alliance station.
    attr_accessor :dc_terminal_near

    # Number of Scored cones in the alliance-colored terminal on the side of the field opposite the alliance station.
    attr_accessor :dc_terminal_far

    attr_accessor :eg_navigated1

    attr_accessor :eg_navigated2

    attr_accessor :minor_penalties

    attr_accessor :major_penalties

    attr_accessor :auto_navigation_points

    attr_accessor :signal_bonus_points

    attr_accessor :auto_junction_cone_points

    attr_accessor :auto_terminal_cone_points

    attr_accessor :dc_junction_cone_points

    attr_accessor :dc_terminal_cone_points

    attr_accessor :ownership_points

    attr_accessor :circuit_points

    attr_accessor :eg_navigation_points

    attr_accessor :auto_points

    attr_accessor :dc_points

    attr_accessor :endgame_points

    attr_accessor :penalty_points_committed

    attr_accessor :pre_penalty_total

    # Array of 4 cone counts scored by this alliance on ground, low, medium, and high junctions respectively, scored in autonomous. E.g. red.autoJunctionCones[2] is the total number of cones scored by red on medium-height junctions.
    attr_accessor :auto_junction_cones

    # Array of 4 cone counts scored by this alliance on ground, low, medium, and high junctions respectively, scored in driver-controlled. E.g. red.dcJunctionCones[2] is the total number of cones scored by red on medium-height junctions.
    attr_accessor :dc_junction_cones

    attr_accessor :beacons

    attr_accessor :owned_junctions

    attr_accessor :circuit

    attr_accessor :total_points

    attr_accessor :alliance

    attr_accessor :team

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'side_of_field' => :'sideOfField',
        :'init_signal_sleeve1' => :'initSignalSleeve1',
        :'init_signal_sleeve2' => :'initSignalSleeve2',
        :'robot1_auto' => :'robot1Auto',
        :'robot2_auto' => :'robot2Auto',
        :'auto_terminal' => :'autoTerminal',
        :'auto_junctions' => :'autoJunctions',
        :'dc_junctions' => :'dcJunctions',
        :'dc_terminal_near' => :'dcTerminalNear',
        :'dc_terminal_far' => :'dcTerminalFar',
        :'eg_navigated1' => :'egNavigated1',
        :'eg_navigated2' => :'egNavigated2',
        :'minor_penalties' => :'minorPenalties',
        :'major_penalties' => :'majorPenalties',
        :'auto_navigation_points' => :'autoNavigationPoints',
        :'signal_bonus_points' => :'signalBonusPoints',
        :'auto_junction_cone_points' => :'autoJunctionConePoints',
        :'auto_terminal_cone_points' => :'autoTerminalConePoints',
        :'dc_junction_cone_points' => :'dcJunctionConePoints',
        :'dc_terminal_cone_points' => :'dcTerminalConePoints',
        :'ownership_points' => :'ownershipPoints',
        :'circuit_points' => :'circuitPoints',
        :'eg_navigation_points' => :'egNavigationPoints',
        :'auto_points' => :'autoPoints',
        :'dc_points' => :'dcPoints',
        :'endgame_points' => :'endgamePoints',
        :'penalty_points_committed' => :'penaltyPointsCommitted',
        :'pre_penalty_total' => :'prePenaltyTotal',
        :'auto_junction_cones' => :'autoJunctionCones',
        :'dc_junction_cones' => :'dcJunctionCones',
        :'beacons' => :'beacons',
        :'owned_junctions' => :'ownedJunctions',
        :'circuit' => :'circuit',
        :'total_points' => :'totalPoints',
        :'alliance' => :'alliance',
        :'team' => :'team'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'side_of_field' => :'Object',
        :'init_signal_sleeve1' => :'Object',
        :'init_signal_sleeve2' => :'Object',
        :'robot1_auto' => :'Object',
        :'robot2_auto' => :'Object',
        :'auto_terminal' => :'Object',
        :'auto_junctions' => :'Object',
        :'dc_junctions' => :'Object',
        :'dc_terminal_near' => :'Object',
        :'dc_terminal_far' => :'Object',
        :'eg_navigated1' => :'Object',
        :'eg_navigated2' => :'Object',
        :'minor_penalties' => :'Object',
        :'major_penalties' => :'Object',
        :'auto_navigation_points' => :'Object',
        :'signal_bonus_points' => :'Object',
        :'auto_junction_cone_points' => :'Object',
        :'auto_terminal_cone_points' => :'Object',
        :'dc_junction_cone_points' => :'Object',
        :'dc_terminal_cone_points' => :'Object',
        :'ownership_points' => :'Object',
        :'circuit_points' => :'Object',
        :'eg_navigation_points' => :'Object',
        :'auto_points' => :'Object',
        :'dc_points' => :'Object',
        :'endgame_points' => :'Object',
        :'penalty_points_committed' => :'Object',
        :'pre_penalty_total' => :'Object',
        :'auto_junction_cones' => :'Object',
        :'dc_junction_cones' => :'Object',
        :'beacons' => :'Object',
        :'owned_junctions' => :'Object',
        :'circuit' => :'Object',
        :'total_points' => :'Object',
        :'alliance' => :'Object',
        :'team' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'auto_junctions',
        :'dc_junctions',
        :'auto_junction_cones',
        :'dc_junction_cones',
        :'alliance',
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `FtcEventsClient::ScoreDetailAllianceModel2022` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `FtcEventsClient::ScoreDetailAllianceModel2022`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'side_of_field')
        self.side_of_field = attributes[:'side_of_field']
      end

      if attributes.key?(:'init_signal_sleeve1')
        self.init_signal_sleeve1 = attributes[:'init_signal_sleeve1']
      end

      if attributes.key?(:'init_signal_sleeve2')
        self.init_signal_sleeve2 = attributes[:'init_signal_sleeve2']
      end

      if attributes.key?(:'robot1_auto')
        self.robot1_auto = attributes[:'robot1_auto']
      end

      if attributes.key?(:'robot2_auto')
        self.robot2_auto = attributes[:'robot2_auto']
      end

      if attributes.key?(:'auto_terminal')
        self.auto_terminal = attributes[:'auto_terminal']
      end

      if attributes.key?(:'auto_junctions')
        if (value = attributes[:'auto_junctions']).is_a?(Array)
          self.auto_junctions = value
        end
      end

      if attributes.key?(:'dc_junctions')
        if (value = attributes[:'dc_junctions']).is_a?(Array)
          self.dc_junctions = value
        end
      end

      if attributes.key?(:'dc_terminal_near')
        self.dc_terminal_near = attributes[:'dc_terminal_near']
      end

      if attributes.key?(:'dc_terminal_far')
        self.dc_terminal_far = attributes[:'dc_terminal_far']
      end

      if attributes.key?(:'eg_navigated1')
        self.eg_navigated1 = attributes[:'eg_navigated1']
      end

      if attributes.key?(:'eg_navigated2')
        self.eg_navigated2 = attributes[:'eg_navigated2']
      end

      if attributes.key?(:'minor_penalties')
        self.minor_penalties = attributes[:'minor_penalties']
      end

      if attributes.key?(:'major_penalties')
        self.major_penalties = attributes[:'major_penalties']
      end

      if attributes.key?(:'auto_navigation_points')
        self.auto_navigation_points = attributes[:'auto_navigation_points']
      end

      if attributes.key?(:'signal_bonus_points')
        self.signal_bonus_points = attributes[:'signal_bonus_points']
      end

      if attributes.key?(:'auto_junction_cone_points')
        self.auto_junction_cone_points = attributes[:'auto_junction_cone_points']
      end

      if attributes.key?(:'auto_terminal_cone_points')
        self.auto_terminal_cone_points = attributes[:'auto_terminal_cone_points']
      end

      if attributes.key?(:'dc_junction_cone_points')
        self.dc_junction_cone_points = attributes[:'dc_junction_cone_points']
      end

      if attributes.key?(:'dc_terminal_cone_points')
        self.dc_terminal_cone_points = attributes[:'dc_terminal_cone_points']
      end

      if attributes.key?(:'ownership_points')
        self.ownership_points = attributes[:'ownership_points']
      end

      if attributes.key?(:'circuit_points')
        self.circuit_points = attributes[:'circuit_points']
      end

      if attributes.key?(:'eg_navigation_points')
        self.eg_navigation_points = attributes[:'eg_navigation_points']
      end

      if attributes.key?(:'auto_points')
        self.auto_points = attributes[:'auto_points']
      end

      if attributes.key?(:'dc_points')
        self.dc_points = attributes[:'dc_points']
      end

      if attributes.key?(:'endgame_points')
        self.endgame_points = attributes[:'endgame_points']
      end

      if attributes.key?(:'penalty_points_committed')
        self.penalty_points_committed = attributes[:'penalty_points_committed']
      end

      if attributes.key?(:'pre_penalty_total')
        self.pre_penalty_total = attributes[:'pre_penalty_total']
      end

      if attributes.key?(:'auto_junction_cones')
        if (value = attributes[:'auto_junction_cones']).is_a?(Array)
          self.auto_junction_cones = value
        end
      end

      if attributes.key?(:'dc_junction_cones')
        if (value = attributes[:'dc_junction_cones']).is_a?(Array)
          self.dc_junction_cones = value
        end
      end

      if attributes.key?(:'beacons')
        self.beacons = attributes[:'beacons']
      end

      if attributes.key?(:'owned_junctions')
        self.owned_junctions = attributes[:'owned_junctions']
      end

      if attributes.key?(:'circuit')
        self.circuit = attributes[:'circuit']
      end

      if attributes.key?(:'total_points')
        self.total_points = attributes[:'total_points']
      end

      if attributes.key?(:'alliance')
        self.alliance = attributes[:'alliance']
      end

      if attributes.key?(:'team')
        self.team = attributes[:'team']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          side_of_field == o.side_of_field &&
          init_signal_sleeve1 == o.init_signal_sleeve1 &&
          init_signal_sleeve2 == o.init_signal_sleeve2 &&
          robot1_auto == o.robot1_auto &&
          robot2_auto == o.robot2_auto &&
          auto_terminal == o.auto_terminal &&
          auto_junctions == o.auto_junctions &&
          dc_junctions == o.dc_junctions &&
          dc_terminal_near == o.dc_terminal_near &&
          dc_terminal_far == o.dc_terminal_far &&
          eg_navigated1 == o.eg_navigated1 &&
          eg_navigated2 == o.eg_navigated2 &&
          minor_penalties == o.minor_penalties &&
          major_penalties == o.major_penalties &&
          auto_navigation_points == o.auto_navigation_points &&
          signal_bonus_points == o.signal_bonus_points &&
          auto_junction_cone_points == o.auto_junction_cone_points &&
          auto_terminal_cone_points == o.auto_terminal_cone_points &&
          dc_junction_cone_points == o.dc_junction_cone_points &&
          dc_terminal_cone_points == o.dc_terminal_cone_points &&
          ownership_points == o.ownership_points &&
          circuit_points == o.circuit_points &&
          eg_navigation_points == o.eg_navigation_points &&
          auto_points == o.auto_points &&
          dc_points == o.dc_points &&
          endgame_points == o.endgame_points &&
          penalty_points_committed == o.penalty_points_committed &&
          pre_penalty_total == o.pre_penalty_total &&
          auto_junction_cones == o.auto_junction_cones &&
          dc_junction_cones == o.dc_junction_cones &&
          beacons == o.beacons &&
          owned_junctions == o.owned_junctions &&
          circuit == o.circuit &&
          total_points == o.total_points &&
          alliance == o.alliance &&
          team == o.team
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [side_of_field, init_signal_sleeve1, init_signal_sleeve2, robot1_auto, robot2_auto, auto_terminal, auto_junctions, dc_junctions, dc_terminal_near, dc_terminal_far, eg_navigated1, eg_navigated2, minor_penalties, major_penalties, auto_navigation_points, signal_bonus_points, auto_junction_cone_points, auto_terminal_cone_points, dc_junction_cone_points, dc_terminal_cone_points, ownership_points, circuit_points, eg_navigation_points, auto_points, dc_points, endgame_points, penalty_points_committed, pre_penalty_total, auto_junction_cones, dc_junction_cones, beacons, owned_junctions, circuit, total_points, alliance, team].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def self.build_from_hash(attributes)
      new.build_from_hash(attributes)
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.openapi_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        elsif attributes[self.class.attribute_map[key]].nil? && self.class.openapi_nullable.include?(key)
          self.send("#{key}=", nil)
        end
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :Boolean
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        FtcEventsClient.const_get(type).build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        if value.nil?
          is_nullable = self.class.openapi_nullable.include?(attr)
          next if !is_nullable || (is_nullable && !instance_variable_defined?(:"@#{attr}"))
        end

        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end  end
end
