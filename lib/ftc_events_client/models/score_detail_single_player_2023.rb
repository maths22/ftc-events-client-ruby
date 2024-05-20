=begin
#FTC Events API

#FTC Events API is a service to return relevant information about the _FIRST_ Tech Challenge (FTC). Information is made available from events operating around the world  Information is currently made available after the conclusion of the tournament.  The API will provide data as soon as it has synced, and we do not add any artificial delays.  ## Documentation Notes  ### Timezones  All times are listed in the local time to the event venue. HTTP-date values will show their timezone.  ### Query Parameters  If you specify a parameter, but no value for that parameter, it will be ignored. For example, if you request `URL?teamNumber=` the `teamNumber` parameter would be ignored.  For all APIs that accept a query string in addition to the base URI, the order of parameters do not matter, but the name shown in the documentation must match exactly, as does the associated value format as described in details.  For response codes that are not HTTP 200 (OK), the documentation will show a body message that represents a possible response value. While the \"title\" of the HTTP Status Code will match those shown in the response codes documentation section exactly, the body of the response will be a more detailed explanation of why that status code is being returned and may not always be exactly as shown in the examples.  ### Experimenting with the API  This documentation is rendered at both [api-docs](https://ftc-events.firstinspires.org/api-docs) and [try-it-out](https://ftc-events.firstinspires.org/try-it-out).  [api-docs](https://ftc-events.firstinspires.org/api-docs) has a three panel, easy to read layout, while [try-it-out](https://ftc-events.firstinspires.org/try-it-out) has a feature that allows you try out endpoints from within the page.  Additionally, the Open API Json is availabe at [Open API](https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json).  This can be imported into a tool such as [Postman](https://www.postman.com) for experimentation as well.   ### Last-Modified, FMS-OnlyModifiedSince, and If-Modified-Since Headers The FTC Events API utilizes the `Last-Modified` and `If-Modified-Since` Headers to communicate with consumers regarding the age of the data they are requesting. With a couple of exceptions, all calls will return a `Last-Modified` Header set with the time at which the data at that endpoint was last modified. The Header will always be set in the HTTP-date format, as described in the HTTP Protocol. There are two exceptions: the `Last-Modified` Header is not set if the endpoint returns no results (such as a request for a schedule with no matches).  Consumers should keep track of the `Last-Modified` Header, and return it on subsequent calls to the same endpoint as the If-Modified-Since. The server will recognize this request, and will only return a result if the data has been modified since the last request. If no changes have been made, an HTTP 304 will be returned. If data has been modified, ALL data on that call will be returned (for \"only modified\" data, see below).  The FTC Events API also allows a custom header used to filter the return data to a specific subset. This is done by specifying a `FMS-OnlyModifiedSince` header with each call. As with the `If-Modified-Since` header, consumers should keep track of the Last-Modified Header, and return it on subsequent calls to the same endpoint as the `FMS-OnlyModifiedSince` Header. The server will recognize this request, and will only return a result if the data has been modified since the last request, and, if returned, the data will only be those portions modified since the included date. If no changes, have been made, an HTTP 304 will be returned. Using this method, the server and consumer save processing time by only receiving modified data that is in need of update on the consumer side.  If the Headers are improperly passed (such as the wrong Day of Week for the matching date, or a date in the future), the endpoint will simply ignore the Header and return all results. If both headers are specified, the request will be denied.  ## Response Codes  The FTC Events API HTTP Status Codes correspond with the [common codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html), but occasionally with different \"titles\". The \"title\" used by the API is shown next to each of the below possible response HTTP Status Codes. Throughout the documentation, Apiary may automatically show the common \"title\" in example returns (like \"Not Found\" for 404) but on the production server, the \"title\" will instead match those listed below.  ### HTTP 200 - \"OK\" The request has succeeded. An entity corresponding to the requested resource is sent in the response. This will be returned as the HTTP Status Code for all request that succeed, even if the body is empty (such as an event that has no rankings, but with a valid season and event code were used)  ### HTTP 304 - \"Not Modified\" When utilizing a Header that allows filtered data returns, such as `If-Modified-Since`, this response indicates that no data meets the request.  ### HTTP 400 - \"Invalid Season Requested\"/\"Malformed Parameter Format In Request\"/\"Missing Parameter In Request\"/\"Invalid API Version Requested\": The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications. Specifically for this API, a 400 response indicates that the requested URI matches with a valid API, but one or more required parameter was malformed or invalid. Examples include an event code that is too short or team number that contains a letter.  ### HTTP 401 - \"Unauthorized\" All requests against the API require authentication via a valid user token. Failing to provide one, or providing an invalid one, will warrant a 401 response. The client MAY repeat the request with a suitable Authorization header field.  ### HTTP 404 - \"Invalid Event Requested\" Even though the 404 code usually indicates any not found status, a 404 will only be issued in this API when an event cannot be found for the requested season and event code. If the request didn't match a valid API or there were malformed parameters, the response would not receive a 404 but rather a 400 or 501. If this HTTP code is received, the season was a valid season and the event code matched the acceptable style of an event code, but there were no records of an event matching the combination of that season and event code. For example, HTTP 404 would be issued when the event had a different code in the requested season (the codes can change year to year based on event location).  ### HTTP 500 - \"Internal Server Error\" The server encountered an unexpected condition which prevented it from fulfilling the request. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ### HTTP 501 - \"Request Did Not Match Any Current API Pattern\" The server does not support the functionality required to fulfill the request. Specifically, the request pattern did not match any of the possible APIs, and thus processing was discontinued. This code is also issued when too many optional parameters were included in a single request and fulfilling it would make the result confusing or misleading. Each API will specify which parameters or combination of parameters can be used at the same time.  ### HTTP 503 - \"Service Unavailable\" The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a `Retry-After` header. This code will not always appear, sometimes the server may outright refuse the connection instead. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ## Authorization In order to make calls against the FTC Events API, you must include an HTTP Header called `Authorization` with the value set as specified below. If a request is made without this header, processing stops and an HTTP 401 is issued. All `Authorization` headers follow the same format:  ``` Authorization: Basic 000000000000000000000000000000000000000000000000000000000000 ```  Where the Zeros are replaced by your Token. The Token can be formed by taking your username and your AuthorizationKey and adding a colon. For example, if your username is `sampleuser` and your AuthorizationKey is `7eaa6338-a097-4221-ac04-b6120fcc4d49` you would have this string:  ``` sampleuser:7eaa6338-a097-4221-ac04-b6120fcc4d49 ```  This string must then be encoded using Base64 Encoded to form the Token, which will be the same length as the example above, but include letters and numbers. For our example, we would have:  ``` c2FtcGxldXNlcjo3ZWFhNjMzOC1hMDk3LTQyMjEtYWMwNC1iNjEyMGZjYzRkNDk= ```  Most API client libraries can handle computing the authorization header using a username and password for you  NOTICE: Publicly distributing an application, code snippet, etc, that has your username and token in it, encoded or not, WILL result in your token being blocked from the API. Each user should apply for their own token.  If you wish to acquire a token for your development, you may do so by requesting a token through our automated system on this website. 

OpenAPI spec version: v2.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.52
=end

require 'date'

module FtcEventsClient
  class ScoreDetailSinglePlayer2023
    attr_accessor :init_team_prop

    attr_accessor :robot_auto

    attr_accessor :spike_mark_pixel

    attr_accessor :target_backdrop_pixel

    attr_accessor :auto_backdrop

    attr_accessor :auto_backstage

    attr_accessor :dc_backdrop

    attr_accessor :dc_backstage

    attr_accessor :mosaics

    attr_accessor :max_set_line

    attr_accessor :eg_robot

    attr_accessor :drone

    attr_accessor :minor_penalties

    attr_accessor :major_penalties

    attr_accessor :auto_navigating_points

    attr_accessor :auto_randomization_points

    attr_accessor :auto_backstage_points

    attr_accessor :auto_backdrop_points

    attr_accessor :dc_backdrop_points

    attr_accessor :dc_backstage_points

    attr_accessor :mosaic_points

    attr_accessor :set_bonus_points

    attr_accessor :eg_location_points

    attr_accessor :eg_drone_points

    attr_accessor :auto_points

    attr_accessor :dc_points

    attr_accessor :endgame_points

    attr_accessor :penalty_points_committed

    attr_accessor :pre_penalty_total

    attr_accessor :total_points

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'init_team_prop' => :'initTeamProp',
        :'robot_auto' => :'robotAuto',
        :'spike_mark_pixel' => :'spikeMarkPixel',
        :'target_backdrop_pixel' => :'targetBackdropPixel',
        :'auto_backdrop' => :'autoBackdrop',
        :'auto_backstage' => :'autoBackstage',
        :'dc_backdrop' => :'dcBackdrop',
        :'dc_backstage' => :'dcBackstage',
        :'mosaics' => :'mosaics',
        :'max_set_line' => :'maxSetLine',
        :'eg_robot' => :'egRobot',
        :'drone' => :'drone',
        :'minor_penalties' => :'minorPenalties',
        :'major_penalties' => :'majorPenalties',
        :'auto_navigating_points' => :'autoNavigatingPoints',
        :'auto_randomization_points' => :'autoRandomizationPoints',
        :'auto_backstage_points' => :'autoBackstagePoints',
        :'auto_backdrop_points' => :'autoBackdropPoints',
        :'dc_backdrop_points' => :'dcBackdropPoints',
        :'dc_backstage_points' => :'dcBackstagePoints',
        :'mosaic_points' => :'mosaicPoints',
        :'set_bonus_points' => :'setBonusPoints',
        :'eg_location_points' => :'egLocationPoints',
        :'eg_drone_points' => :'egDronePoints',
        :'auto_points' => :'autoPoints',
        :'dc_points' => :'dcPoints',
        :'endgame_points' => :'endgamePoints',
        :'penalty_points_committed' => :'penaltyPointsCommitted',
        :'pre_penalty_total' => :'prePenaltyTotal',
        :'total_points' => :'totalPoints'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'init_team_prop' => :'Object',
        :'robot_auto' => :'Object',
        :'spike_mark_pixel' => :'Object',
        :'target_backdrop_pixel' => :'Object',
        :'auto_backdrop' => :'Object',
        :'auto_backstage' => :'Object',
        :'dc_backdrop' => :'Object',
        :'dc_backstage' => :'Object',
        :'mosaics' => :'Object',
        :'max_set_line' => :'Object',
        :'eg_robot' => :'Object',
        :'drone' => :'Object',
        :'minor_penalties' => :'Object',
        :'major_penalties' => :'Object',
        :'auto_navigating_points' => :'Object',
        :'auto_randomization_points' => :'Object',
        :'auto_backstage_points' => :'Object',
        :'auto_backdrop_points' => :'Object',
        :'dc_backdrop_points' => :'Object',
        :'dc_backstage_points' => :'Object',
        :'mosaic_points' => :'Object',
        :'set_bonus_points' => :'Object',
        :'eg_location_points' => :'Object',
        :'eg_drone_points' => :'Object',
        :'auto_points' => :'Object',
        :'dc_points' => :'Object',
        :'endgame_points' => :'Object',
        :'penalty_points_committed' => :'Object',
        :'pre_penalty_total' => :'Object',
        :'total_points' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `FtcEventsClient::ScoreDetailSinglePlayer2023` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `FtcEventsClient::ScoreDetailSinglePlayer2023`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'init_team_prop')
        self.init_team_prop = attributes[:'init_team_prop']
      end

      if attributes.key?(:'robot_auto')
        self.robot_auto = attributes[:'robot_auto']
      end

      if attributes.key?(:'spike_mark_pixel')
        self.spike_mark_pixel = attributes[:'spike_mark_pixel']
      end

      if attributes.key?(:'target_backdrop_pixel')
        self.target_backdrop_pixel = attributes[:'target_backdrop_pixel']
      end

      if attributes.key?(:'auto_backdrop')
        self.auto_backdrop = attributes[:'auto_backdrop']
      end

      if attributes.key?(:'auto_backstage')
        self.auto_backstage = attributes[:'auto_backstage']
      end

      if attributes.key?(:'dc_backdrop')
        self.dc_backdrop = attributes[:'dc_backdrop']
      end

      if attributes.key?(:'dc_backstage')
        self.dc_backstage = attributes[:'dc_backstage']
      end

      if attributes.key?(:'mosaics')
        self.mosaics = attributes[:'mosaics']
      end

      if attributes.key?(:'max_set_line')
        self.max_set_line = attributes[:'max_set_line']
      end

      if attributes.key?(:'eg_robot')
        self.eg_robot = attributes[:'eg_robot']
      end

      if attributes.key?(:'drone')
        self.drone = attributes[:'drone']
      end

      if attributes.key?(:'minor_penalties')
        self.minor_penalties = attributes[:'minor_penalties']
      end

      if attributes.key?(:'major_penalties')
        self.major_penalties = attributes[:'major_penalties']
      end

      if attributes.key?(:'auto_navigating_points')
        self.auto_navigating_points = attributes[:'auto_navigating_points']
      end

      if attributes.key?(:'auto_randomization_points')
        self.auto_randomization_points = attributes[:'auto_randomization_points']
      end

      if attributes.key?(:'auto_backstage_points')
        self.auto_backstage_points = attributes[:'auto_backstage_points']
      end

      if attributes.key?(:'auto_backdrop_points')
        self.auto_backdrop_points = attributes[:'auto_backdrop_points']
      end

      if attributes.key?(:'dc_backdrop_points')
        self.dc_backdrop_points = attributes[:'dc_backdrop_points']
      end

      if attributes.key?(:'dc_backstage_points')
        self.dc_backstage_points = attributes[:'dc_backstage_points']
      end

      if attributes.key?(:'mosaic_points')
        self.mosaic_points = attributes[:'mosaic_points']
      end

      if attributes.key?(:'set_bonus_points')
        self.set_bonus_points = attributes[:'set_bonus_points']
      end

      if attributes.key?(:'eg_location_points')
        self.eg_location_points = attributes[:'eg_location_points']
      end

      if attributes.key?(:'eg_drone_points')
        self.eg_drone_points = attributes[:'eg_drone_points']
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

      if attributes.key?(:'total_points')
        self.total_points = attributes[:'total_points']
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
          init_team_prop == o.init_team_prop &&
          robot_auto == o.robot_auto &&
          spike_mark_pixel == o.spike_mark_pixel &&
          target_backdrop_pixel == o.target_backdrop_pixel &&
          auto_backdrop == o.auto_backdrop &&
          auto_backstage == o.auto_backstage &&
          dc_backdrop == o.dc_backdrop &&
          dc_backstage == o.dc_backstage &&
          mosaics == o.mosaics &&
          max_set_line == o.max_set_line &&
          eg_robot == o.eg_robot &&
          drone == o.drone &&
          minor_penalties == o.minor_penalties &&
          major_penalties == o.major_penalties &&
          auto_navigating_points == o.auto_navigating_points &&
          auto_randomization_points == o.auto_randomization_points &&
          auto_backstage_points == o.auto_backstage_points &&
          auto_backdrop_points == o.auto_backdrop_points &&
          dc_backdrop_points == o.dc_backdrop_points &&
          dc_backstage_points == o.dc_backstage_points &&
          mosaic_points == o.mosaic_points &&
          set_bonus_points == o.set_bonus_points &&
          eg_location_points == o.eg_location_points &&
          eg_drone_points == o.eg_drone_points &&
          auto_points == o.auto_points &&
          dc_points == o.dc_points &&
          endgame_points == o.endgame_points &&
          penalty_points_committed == o.penalty_points_committed &&
          pre_penalty_total == o.pre_penalty_total &&
          total_points == o.total_points
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [init_team_prop, robot_auto, spike_mark_pixel, target_backdrop_pixel, auto_backdrop, auto_backstage, dc_backdrop, dc_backstage, mosaics, max_set_line, eg_robot, drone, minor_penalties, major_penalties, auto_navigating_points, auto_randomization_points, auto_backstage_points, auto_backdrop_points, dc_backdrop_points, dc_backstage_points, mosaic_points, set_bonus_points, eg_location_points, eg_drone_points, auto_points, dc_points, endgame_points, penalty_points_committed, pre_penalty_total, total_points].hash
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
