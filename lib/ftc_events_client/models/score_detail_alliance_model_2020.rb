=begin
#FTC Events API

#FTC Events API is a service to return relevant information about the _FIRST_ Tech Challenge (FTC). Information is made available from events operating around the world  Information is currently made available after the conclusion of the tournament.  The API will provide data as soon as it has synced, and we do not add any artificial delays.  ## Documentation Notes  ### Timezones  All times are listed in the local time to the event venue. HTTP-date values will show their timezone.  ### Query Parameters  If you specify a parameter, but no value for that parameter, it will be ignored. For example, if you request `URL?teamNumber=` the `teamNumber` parameter would be ignored.  For all APIs that accept a query string in addition to the base URI, the order of parameters do not matter, but the name shown in the documentation must match exactly, as does the associated value format as described in details.  For response codes that are not HTTP 200 (OK), the documentation will show a body message that represents a possible response value. While the \"title\" of the HTTP Status Code will match those shown in the response codes documentation section exactly, the body of the response will be a more detailed explanation of why that status code is being returned and may not always be exactly as shown in the examples.  ### Experimenting with the API  This documentation is rendered at both [api-docs](https://ftc-events.firstinspires.org/api-docs) and [try-it-out](https://ftc-events.firstinspires.org/try-it-out).  [api-docs](https://ftc-events.firstinspires.org/api-docs) has a three panel, easy to read layout, while [try-it-out](https://ftc-events.firstinspires.org/try-it-out) has a feature that allows you try out endpoints from within the page.  Additionally, the Open API Json is availabe at [Open API](https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json).  This can be imported into a tool such as [Postman](https://www.postman.com) for experimentation as well.   ### Last-Modified, FMS-OnlyModifiedSince, and If-Modified-Since Headers The FTC Events API utilizes the `Last-Modified` and `If-Modified-Since` Headers to communicate with consumers regarding the age of the data they are requesting. With a couple of exceptions, all calls will return a `Last-Modified` Header set with the time at which the data at that endpoint was last modified. The Header will always be set in the HTTP-date format, as described in the HTTP Protocol. There are two exceptions: the `Last-Modified` Header is not set if the endpoint returns no results (such as a request for a schedule with no matches).  Consumers should keep track of the `Last-Modified` Header, and return it on subsequent calls to the same endpoint as the If-Modified-Since. The server will recognize this request, and will only return a result if the data has been modified since the last request. If no changes have been made, an HTTP 304 will be returned. If data has been modified, ALL data on that call will be returned (for \"only modified\" data, see below).  The FTC Events API also allows a custom header used to filter the return data to a specific subset. This is done by specifying a `FMS-OnlyModifiedSince` header with each call. As with the `If-Modified-Since` header, consumers should keep track of the Last-Modified Header, and return it on subsequent calls to the same endpoint as the `FMS-OnlyModifiedSince` Header. The server will recognize this request, and will only return a result if the data has been modified since the last request, and, if returned, the data will only be those portions modified since the included date. If no changes, have been made, an HTTP 304 will be returned. Using this method, the server and consumer save processing time by only receiving modified data that is in need of update on the consumer side.  If the Headers are improperly passed (such as the wrong Day of Week for the matching date, or a date in the future), the endpoint will simply ignore the Header and return all results. If both headers are specified, the request will be denied.  ## Response Codes  The FTC Events API HTTP Status Codes correspond with the [common codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html), but occasionally with different \"titles\". The \"title\" used by the API is shown next to each of the below possible response HTTP Status Codes. Throughout the documentation, Apiary may automatically show the common \"title\" in example returns (like \"Not Found\" for 404) but on the production server, the \"title\" will instead match those listed below.  ### HTTP 200 - \"OK\" The request has succeeded. An entity corresponding to the requested resource is sent in the response. This will be returned as the HTTP Status Code for all request that succeed, even if the body is empty (such as an event that has no rankings, but with a valid season and event code were used)  ### HTTP 304 - \"Not Modified\" When utilizing a Header that allows filtered data returns, such as `If-Modified-Since`, this response indicates that no data meets the request.  ### HTTP 400 - \"Invalid Season Requested\"/\"Malformed Parameter Format In Request\"/\"Missing Parameter In Request\"/\"Invalid API Version Requested\": The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications. Specifically for this API, a 400 response indicates that the requested URI matches with a valid API, but one or more required parameter was malformed or invalid. Examples include an event code that is too short or team number that contains a letter.  ### HTTP 401 - \"Unauthorized\" All requests against the API require authentication via a valid user token. Failing to provide one, or providing an invalid one, will warrant a 401 response. The client MAY repeat the request with a suitable Authorization header field.  ### HTTP 404 - \"Invalid Event Requested\" Even though the 404 code usually indicates any not found status, a 404 will only be issued in this API when an event cannot be found for the requested season and event code. If the request didn't match a valid API or there were malformed parameters, the response would not receive a 404 but rather a 400 or 501. If this HTTP code is received, the season was a valid season and the event code matched the acceptable style of an event code, but there were no records of an event matching the combination of that season and event code. For example, HTTP 404 would be issued when the event had a different code in the requested season (the codes can change year to year based on event location).  ### HTTP 500 - \"Internal Server Error\" The server encountered an unexpected condition which prevented it from fulfilling the request. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ### HTTP 501 - \"Request Did Not Match Any Current API Pattern\" The server does not support the functionality required to fulfill the request. Specifically, the request pattern did not match any of the possible APIs, and thus processing was discontinued. This code is also issued when too many optional parameters were included in a single request and fulfilling it would make the result confusing or misleading. Each API will specify which parameters or combination of parameters can be used at the same time.  ### HTTP 503 - \"Service Unavailable\" The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a `Retry-After` header. This code will not always appear, sometimes the server may outright refuse the connection instead. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ## Authorization In order to make calls against the FTC Events API, you must include an HTTP Header called `Authorization` with the value set as specified below. If a request is made without this header, processing stops and an HTTP 401 is issued. All `Authorization` headers follow the same format:  ``` Authorization: Basic 000000000000000000000000000000000000000000000000000000000000 ```  Where the Zeros are replaced by your Token. The Token can be formed by taking your username and your AuthorizationKey and adding a colon. For example, if your username is `sampleuser` and your AuthorizationKey is `7eaa6338-a097-4221-ac04-b6120fcc4d49` you would have this string:  ``` sampleuser:7eaa6338-a097-4221-ac04-b6120fcc4d49 ```  This string must then be encoded using Base64 Encoded to form the Token, which will be the same length as the example above, but include letters and numbers. For our example, we would have:  ``` c2FtcGxldXNlcjo3ZWFhNjMzOC1hMDk3LTQyMjEtYWMwNC1iNjEyMGZjYzRkNDk= ```  Most API client libraries can handle computing the authorization header using a username and password for you  NOTICE: Publicly distributing an application, code snippet, etc, that has your username and token in it, encoded or not, WILL result in your token being blocked from the API. Each user should apply for their own token.  If you wish to acquire a token for your development, you may do so by requesting a token through our automated system on this website. 

OpenAPI spec version: v2.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.52
=end

require 'date'

module FtcEventsClient
  class ScoreDetailAllianceModel2020
    attr_accessor :adjust

    attr_accessor :dc_points

    attr_accessor :auto_points

    attr_accessor :dc_tower_low

    attr_accessor :dc_tower_mid

    attr_accessor :dc_tower_high

    attr_accessor :navigated1

    attr_accessor :navigated2

    attr_accessor :wobble_delivered1

    attr_accessor :wobble_delivered2

    attr_accessor :auto_tower_low

    attr_accessor :auto_tower_mid

    attr_accessor :auto_tower_high

    attr_accessor :auto_tower_points

    attr_accessor :auto_power_shot_left

    attr_accessor :auto_power_shot_center

    attr_accessor :auto_power_shot_right

    attr_accessor :auto_power_shot_points

    attr_accessor :wobble_rings1

    attr_accessor :wobble_rings2

    attr_accessor :wobble_end1

    attr_accessor :wobble_end2

    attr_accessor :wobble_end_points

    attr_accessor :wobble_ring_points

    attr_accessor :auto_wobble_points

    attr_accessor :end_power_shot_left

    attr_accessor :end_power_shot_center

    attr_accessor :end_power_shot_right

    attr_accessor :end_power_shot_points

    attr_accessor :penalty_points

    attr_accessor :major_penalties

    attr_accessor :minor_penalties

    attr_accessor :navigation_points

    attr_accessor :endgame_points

    attr_accessor :total_points

    attr_accessor :alliance

    attr_accessor :team

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'adjust' => :'adjust',
        :'dc_points' => :'dcPoints',
        :'auto_points' => :'autoPoints',
        :'dc_tower_low' => :'dcTowerLow',
        :'dc_tower_mid' => :'dcTowerMid',
        :'dc_tower_high' => :'dcTowerHigh',
        :'navigated1' => :'navigated1',
        :'navigated2' => :'navigated2',
        :'wobble_delivered1' => :'wobbleDelivered1',
        :'wobble_delivered2' => :'wobbleDelivered2',
        :'auto_tower_low' => :'autoTowerLow',
        :'auto_tower_mid' => :'autoTowerMid',
        :'auto_tower_high' => :'autoTowerHigh',
        :'auto_tower_points' => :'autoTowerPoints',
        :'auto_power_shot_left' => :'autoPowerShotLeft',
        :'auto_power_shot_center' => :'autoPowerShotCenter',
        :'auto_power_shot_right' => :'autoPowerShotRight',
        :'auto_power_shot_points' => :'autoPowerShotPoints',
        :'wobble_rings1' => :'wobbleRings1',
        :'wobble_rings2' => :'wobbleRings2',
        :'wobble_end1' => :'wobbleEnd1',
        :'wobble_end2' => :'wobbleEnd2',
        :'wobble_end_points' => :'wobbleEndPoints',
        :'wobble_ring_points' => :'wobbleRingPoints',
        :'auto_wobble_points' => :'autoWobblePoints',
        :'end_power_shot_left' => :'endPowerShotLeft',
        :'end_power_shot_center' => :'endPowerShotCenter',
        :'end_power_shot_right' => :'endPowerShotRight',
        :'end_power_shot_points' => :'endPowerShotPoints',
        :'penalty_points' => :'penaltyPoints',
        :'major_penalties' => :'majorPenalties',
        :'minor_penalties' => :'minorPenalties',
        :'navigation_points' => :'navigationPoints',
        :'endgame_points' => :'endgamePoints',
        :'total_points' => :'totalPoints',
        :'alliance' => :'alliance',
        :'team' => :'team'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'adjust' => :'Object',
        :'dc_points' => :'Object',
        :'auto_points' => :'Object',
        :'dc_tower_low' => :'Object',
        :'dc_tower_mid' => :'Object',
        :'dc_tower_high' => :'Object',
        :'navigated1' => :'Object',
        :'navigated2' => :'Object',
        :'wobble_delivered1' => :'Object',
        :'wobble_delivered2' => :'Object',
        :'auto_tower_low' => :'Object',
        :'auto_tower_mid' => :'Object',
        :'auto_tower_high' => :'Object',
        :'auto_tower_points' => :'Object',
        :'auto_power_shot_left' => :'Object',
        :'auto_power_shot_center' => :'Object',
        :'auto_power_shot_right' => :'Object',
        :'auto_power_shot_points' => :'Object',
        :'wobble_rings1' => :'Object',
        :'wobble_rings2' => :'Object',
        :'wobble_end1' => :'Object',
        :'wobble_end2' => :'Object',
        :'wobble_end_points' => :'Object',
        :'wobble_ring_points' => :'Object',
        :'auto_wobble_points' => :'Object',
        :'end_power_shot_left' => :'Object',
        :'end_power_shot_center' => :'Object',
        :'end_power_shot_right' => :'Object',
        :'end_power_shot_points' => :'Object',
        :'penalty_points' => :'Object',
        :'major_penalties' => :'Object',
        :'minor_penalties' => :'Object',
        :'navigation_points' => :'Object',
        :'endgame_points' => :'Object',
        :'total_points' => :'Object',
        :'alliance' => :'Object',
        :'team' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'alliance',
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `FtcEventsClient::ScoreDetailAllianceModel2020` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `FtcEventsClient::ScoreDetailAllianceModel2020`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'adjust')
        self.adjust = attributes[:'adjust']
      end

      if attributes.key?(:'dc_points')
        self.dc_points = attributes[:'dc_points']
      end

      if attributes.key?(:'auto_points')
        self.auto_points = attributes[:'auto_points']
      end

      if attributes.key?(:'dc_tower_low')
        self.dc_tower_low = attributes[:'dc_tower_low']
      end

      if attributes.key?(:'dc_tower_mid')
        self.dc_tower_mid = attributes[:'dc_tower_mid']
      end

      if attributes.key?(:'dc_tower_high')
        self.dc_tower_high = attributes[:'dc_tower_high']
      end

      if attributes.key?(:'navigated1')
        self.navigated1 = attributes[:'navigated1']
      end

      if attributes.key?(:'navigated2')
        self.navigated2 = attributes[:'navigated2']
      end

      if attributes.key?(:'wobble_delivered1')
        self.wobble_delivered1 = attributes[:'wobble_delivered1']
      end

      if attributes.key?(:'wobble_delivered2')
        self.wobble_delivered2 = attributes[:'wobble_delivered2']
      end

      if attributes.key?(:'auto_tower_low')
        self.auto_tower_low = attributes[:'auto_tower_low']
      end

      if attributes.key?(:'auto_tower_mid')
        self.auto_tower_mid = attributes[:'auto_tower_mid']
      end

      if attributes.key?(:'auto_tower_high')
        self.auto_tower_high = attributes[:'auto_tower_high']
      end

      if attributes.key?(:'auto_tower_points')
        self.auto_tower_points = attributes[:'auto_tower_points']
      end

      if attributes.key?(:'auto_power_shot_left')
        self.auto_power_shot_left = attributes[:'auto_power_shot_left']
      end

      if attributes.key?(:'auto_power_shot_center')
        self.auto_power_shot_center = attributes[:'auto_power_shot_center']
      end

      if attributes.key?(:'auto_power_shot_right')
        self.auto_power_shot_right = attributes[:'auto_power_shot_right']
      end

      if attributes.key?(:'auto_power_shot_points')
        self.auto_power_shot_points = attributes[:'auto_power_shot_points']
      end

      if attributes.key?(:'wobble_rings1')
        self.wobble_rings1 = attributes[:'wobble_rings1']
      end

      if attributes.key?(:'wobble_rings2')
        self.wobble_rings2 = attributes[:'wobble_rings2']
      end

      if attributes.key?(:'wobble_end1')
        self.wobble_end1 = attributes[:'wobble_end1']
      end

      if attributes.key?(:'wobble_end2')
        self.wobble_end2 = attributes[:'wobble_end2']
      end

      if attributes.key?(:'wobble_end_points')
        self.wobble_end_points = attributes[:'wobble_end_points']
      end

      if attributes.key?(:'wobble_ring_points')
        self.wobble_ring_points = attributes[:'wobble_ring_points']
      end

      if attributes.key?(:'auto_wobble_points')
        self.auto_wobble_points = attributes[:'auto_wobble_points']
      end

      if attributes.key?(:'end_power_shot_left')
        self.end_power_shot_left = attributes[:'end_power_shot_left']
      end

      if attributes.key?(:'end_power_shot_center')
        self.end_power_shot_center = attributes[:'end_power_shot_center']
      end

      if attributes.key?(:'end_power_shot_right')
        self.end_power_shot_right = attributes[:'end_power_shot_right']
      end

      if attributes.key?(:'end_power_shot_points')
        self.end_power_shot_points = attributes[:'end_power_shot_points']
      end

      if attributes.key?(:'penalty_points')
        self.penalty_points = attributes[:'penalty_points']
      end

      if attributes.key?(:'major_penalties')
        self.major_penalties = attributes[:'major_penalties']
      end

      if attributes.key?(:'minor_penalties')
        self.minor_penalties = attributes[:'minor_penalties']
      end

      if attributes.key?(:'navigation_points')
        self.navigation_points = attributes[:'navigation_points']
      end

      if attributes.key?(:'endgame_points')
        self.endgame_points = attributes[:'endgame_points']
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
          adjust == o.adjust &&
          dc_points == o.dc_points &&
          auto_points == o.auto_points &&
          dc_tower_low == o.dc_tower_low &&
          dc_tower_mid == o.dc_tower_mid &&
          dc_tower_high == o.dc_tower_high &&
          navigated1 == o.navigated1 &&
          navigated2 == o.navigated2 &&
          wobble_delivered1 == o.wobble_delivered1 &&
          wobble_delivered2 == o.wobble_delivered2 &&
          auto_tower_low == o.auto_tower_low &&
          auto_tower_mid == o.auto_tower_mid &&
          auto_tower_high == o.auto_tower_high &&
          auto_tower_points == o.auto_tower_points &&
          auto_power_shot_left == o.auto_power_shot_left &&
          auto_power_shot_center == o.auto_power_shot_center &&
          auto_power_shot_right == o.auto_power_shot_right &&
          auto_power_shot_points == o.auto_power_shot_points &&
          wobble_rings1 == o.wobble_rings1 &&
          wobble_rings2 == o.wobble_rings2 &&
          wobble_end1 == o.wobble_end1 &&
          wobble_end2 == o.wobble_end2 &&
          wobble_end_points == o.wobble_end_points &&
          wobble_ring_points == o.wobble_ring_points &&
          auto_wobble_points == o.auto_wobble_points &&
          end_power_shot_left == o.end_power_shot_left &&
          end_power_shot_center == o.end_power_shot_center &&
          end_power_shot_right == o.end_power_shot_right &&
          end_power_shot_points == o.end_power_shot_points &&
          penalty_points == o.penalty_points &&
          major_penalties == o.major_penalties &&
          minor_penalties == o.minor_penalties &&
          navigation_points == o.navigation_points &&
          endgame_points == o.endgame_points &&
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
      [adjust, dc_points, auto_points, dc_tower_low, dc_tower_mid, dc_tower_high, navigated1, navigated2, wobble_delivered1, wobble_delivered2, auto_tower_low, auto_tower_mid, auto_tower_high, auto_tower_points, auto_power_shot_left, auto_power_shot_center, auto_power_shot_right, auto_power_shot_points, wobble_rings1, wobble_rings2, wobble_end1, wobble_end2, wobble_end_points, wobble_ring_points, auto_wobble_points, end_power_shot_left, end_power_shot_center, end_power_shot_right, end_power_shot_points, penalty_points, major_penalties, minor_penalties, navigation_points, endgame_points, total_points, alliance, team].hash
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
