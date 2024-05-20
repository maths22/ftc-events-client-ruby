=begin
#FTC Events API

#FTC Events API is a service to return relevant information about the _FIRST_ Tech Challenge (FTC). Information is made available from events operating around the world  Information is currently made available after the conclusion of the tournament.  The API will provide data as soon as it has synced, and we do not add any artificial delays.  ## Documentation Notes  ### Timezones  All times are listed in the local time to the event venue. HTTP-date values will show their timezone.  ### Query Parameters  If you specify a parameter, but no value for that parameter, it will be ignored. For example, if you request `URL?teamNumber=` the `teamNumber` parameter would be ignored.  For all APIs that accept a query string in addition to the base URI, the order of parameters do not matter, but the name shown in the documentation must match exactly, as does the associated value format as described in details.  For response codes that are not HTTP 200 (OK), the documentation will show a body message that represents a possible response value. While the \"title\" of the HTTP Status Code will match those shown in the response codes documentation section exactly, the body of the response will be a more detailed explanation of why that status code is being returned and may not always be exactly as shown in the examples.  ### Experimenting with the API  This documentation is rendered at both [api-docs](https://ftc-events.firstinspires.org/api-docs) and [try-it-out](https://ftc-events.firstinspires.org/try-it-out).  [api-docs](https://ftc-events.firstinspires.org/api-docs) has a three panel, easy to read layout, while [try-it-out](https://ftc-events.firstinspires.org/try-it-out) has a feature that allows you try out endpoints from within the page.  Additionally, the Open API Json is availabe at [Open API](https://ftc-events.firstinspires.org/swagger/v2.0/swagger.json).  This can be imported into a tool such as [Postman](https://www.postman.com) for experimentation as well.   ### Last-Modified, FMS-OnlyModifiedSince, and If-Modified-Since Headers The FTC Events API utilizes the `Last-Modified` and `If-Modified-Since` Headers to communicate with consumers regarding the age of the data they are requesting. With a couple of exceptions, all calls will return a `Last-Modified` Header set with the time at which the data at that endpoint was last modified. The Header will always be set in the HTTP-date format, as described in the HTTP Protocol. There are two exceptions: the `Last-Modified` Header is not set if the endpoint returns no results (such as a request for a schedule with no matches).  Consumers should keep track of the `Last-Modified` Header, and return it on subsequent calls to the same endpoint as the If-Modified-Since. The server will recognize this request, and will only return a result if the data has been modified since the last request. If no changes have been made, an HTTP 304 will be returned. If data has been modified, ALL data on that call will be returned (for \"only modified\" data, see below).  The FTC Events API also allows a custom header used to filter the return data to a specific subset. This is done by specifying a `FMS-OnlyModifiedSince` header with each call. As with the `If-Modified-Since` header, consumers should keep track of the Last-Modified Header, and return it on subsequent calls to the same endpoint as the `FMS-OnlyModifiedSince` Header. The server will recognize this request, and will only return a result if the data has been modified since the last request, and, if returned, the data will only be those portions modified since the included date. If no changes, have been made, an HTTP 304 will be returned. Using this method, the server and consumer save processing time by only receiving modified data that is in need of update on the consumer side.  If the Headers are improperly passed (such as the wrong Day of Week for the matching date, or a date in the future), the endpoint will simply ignore the Header and return all results. If both headers are specified, the request will be denied.  ## Response Codes  The FTC Events API HTTP Status Codes correspond with the [common codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html), but occasionally with different \"titles\". The \"title\" used by the API is shown next to each of the below possible response HTTP Status Codes. Throughout the documentation, Apiary may automatically show the common \"title\" in example returns (like \"Not Found\" for 404) but on the production server, the \"title\" will instead match those listed below.  ### HTTP 200 - \"OK\" The request has succeeded. An entity corresponding to the requested resource is sent in the response. This will be returned as the HTTP Status Code for all request that succeed, even if the body is empty (such as an event that has no rankings, but with a valid season and event code were used)  ### HTTP 304 - \"Not Modified\" When utilizing a Header that allows filtered data returns, such as `If-Modified-Since`, this response indicates that no data meets the request.  ### HTTP 400 - \"Invalid Season Requested\"/\"Malformed Parameter Format In Request\"/\"Missing Parameter In Request\"/\"Invalid API Version Requested\": The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications. Specifically for this API, a 400 response indicates that the requested URI matches with a valid API, but one or more required parameter was malformed or invalid. Examples include an event code that is too short or team number that contains a letter.  ### HTTP 401 - \"Unauthorized\" All requests against the API require authentication via a valid user token. Failing to provide one, or providing an invalid one, will warrant a 401 response. The client MAY repeat the request with a suitable Authorization header field.  ### HTTP 404 - \"Invalid Event Requested\" Even though the 404 code usually indicates any not found status, a 404 will only be issued in this API when an event cannot be found for the requested season and event code. If the request didn't match a valid API or there were malformed parameters, the response would not receive a 404 but rather a 400 or 501. If this HTTP code is received, the season was a valid season and the event code matched the acceptable style of an event code, but there were no records of an event matching the combination of that season and event code. For example, HTTP 404 would be issued when the event had a different code in the requested season (the codes can change year to year based on event location).  ### HTTP 500 - \"Internal Server Error\" The server encountered an unexpected condition which prevented it from fulfilling the request. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ### HTTP 501 - \"Request Did Not Match Any Current API Pattern\" The server does not support the functionality required to fulfill the request. Specifically, the request pattern did not match any of the possible APIs, and thus processing was discontinued. This code is also issued when too many optional parameters were included in a single request and fulfilling it would make the result confusing or misleading. Each API will specify which parameters or combination of parameters can be used at the same time.  ### HTTP 503 - \"Service Unavailable\" The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a `Retry-After` header. This code will not always appear, sometimes the server may outright refuse the connection instead. This is a code sent directly by the server, and has no special alternate definition specific to this API.  ## Authorization In order to make calls against the FTC Events API, you must include an HTTP Header called `Authorization` with the value set as specified below. If a request is made without this header, processing stops and an HTTP 401 is issued. All `Authorization` headers follow the same format:  ``` Authorization: Basic 000000000000000000000000000000000000000000000000000000000000 ```  Where the Zeros are replaced by your Token. The Token can be formed by taking your username and your AuthorizationKey and adding a colon. For example, if your username is `sampleuser` and your AuthorizationKey is `7eaa6338-a097-4221-ac04-b6120fcc4d49` you would have this string:  ``` sampleuser:7eaa6338-a097-4221-ac04-b6120fcc4d49 ```  This string must then be encoded using Base64 Encoded to form the Token, which will be the same length as the example above, but include letters and numbers. For our example, we would have:  ``` c2FtcGxldXNlcjo3ZWFhNjMzOC1hMDk3LTQyMjEtYWMwNC1iNjEyMGZjYzRkNDk= ```  Most API client libraries can handle computing the authorization header using a username and password for you  NOTICE: Publicly distributing an application, code snippet, etc, that has your username and token in it, encoded or not, WILL result in your token being blocked from the API. Each user should apply for their own token.  If you wish to acquire a token for your development, you may do so by requesting a token through our automated system on this website. 

OpenAPI spec version: v2.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.52
=end

require 'date'

module FtcEventsClient
  class Geometry
    attr_accessor :factory

    attr_accessor :user_data

    attr_accessor :srid

    attr_accessor :geometry_type

    attr_accessor :ogc_geometry_type

    attr_accessor :precision_model

    attr_accessor :coordinate

    attr_accessor :coordinates

    attr_accessor :num_points

    attr_accessor :num_geometries

    attr_accessor :is_simple

    attr_accessor :is_valid

    attr_accessor :is_empty

    attr_accessor :area

    attr_accessor :length

    attr_accessor :centroid

    attr_accessor :interior_point

    attr_accessor :point_on_surface

    attr_accessor :dimension

    attr_accessor :boundary

    attr_accessor :boundary_dimension

    attr_accessor :envelope

    attr_accessor :envelope_internal

    attr_accessor :is_rectangle

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'factory' => :'factory',
        :'user_data' => :'userData',
        :'srid' => :'srid',
        :'geometry_type' => :'geometryType',
        :'ogc_geometry_type' => :'ogcGeometryType',
        :'precision_model' => :'precisionModel',
        :'coordinate' => :'coordinate',
        :'coordinates' => :'coordinates',
        :'num_points' => :'numPoints',
        :'num_geometries' => :'numGeometries',
        :'is_simple' => :'isSimple',
        :'is_valid' => :'isValid',
        :'is_empty' => :'isEmpty',
        :'area' => :'area',
        :'length' => :'length',
        :'centroid' => :'centroid',
        :'interior_point' => :'interiorPoint',
        :'point_on_surface' => :'pointOnSurface',
        :'dimension' => :'dimension',
        :'boundary' => :'boundary',
        :'boundary_dimension' => :'boundaryDimension',
        :'envelope' => :'envelope',
        :'envelope_internal' => :'envelopeInternal',
        :'is_rectangle' => :'isRectangle'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'factory' => :'Object',
        :'user_data' => :'Object',
        :'srid' => :'Object',
        :'geometry_type' => :'Object',
        :'ogc_geometry_type' => :'Object',
        :'precision_model' => :'Object',
        :'coordinate' => :'Object',
        :'coordinates' => :'Object',
        :'num_points' => :'Object',
        :'num_geometries' => :'Object',
        :'is_simple' => :'Object',
        :'is_valid' => :'Object',
        :'is_empty' => :'Object',
        :'area' => :'Object',
        :'length' => :'Object',
        :'centroid' => :'Object',
        :'interior_point' => :'Object',
        :'point_on_surface' => :'Object',
        :'dimension' => :'Object',
        :'boundary' => :'Object',
        :'boundary_dimension' => :'Object',
        :'envelope' => :'Object',
        :'envelope_internal' => :'Object',
        :'is_rectangle' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'user_data',
        :'geometry_type',
        :'coordinates',
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `FtcEventsClient::Geometry` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `FtcEventsClient::Geometry`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'factory')
        self.factory = attributes[:'factory']
      end

      if attributes.key?(:'user_data')
        self.user_data = attributes[:'user_data']
      end

      if attributes.key?(:'srid')
        self.srid = attributes[:'srid']
      end

      if attributes.key?(:'geometry_type')
        self.geometry_type = attributes[:'geometry_type']
      end

      if attributes.key?(:'ogc_geometry_type')
        self.ogc_geometry_type = attributes[:'ogc_geometry_type']
      end

      if attributes.key?(:'precision_model')
        self.precision_model = attributes[:'precision_model']
      end

      if attributes.key?(:'coordinate')
        self.coordinate = attributes[:'coordinate']
      end

      if attributes.key?(:'coordinates')
        if (value = attributes[:'coordinates']).is_a?(Array)
          self.coordinates = value
        end
      end

      if attributes.key?(:'num_points')
        self.num_points = attributes[:'num_points']
      end

      if attributes.key?(:'num_geometries')
        self.num_geometries = attributes[:'num_geometries']
      end

      if attributes.key?(:'is_simple')
        self.is_simple = attributes[:'is_simple']
      end

      if attributes.key?(:'is_valid')
        self.is_valid = attributes[:'is_valid']
      end

      if attributes.key?(:'is_empty')
        self.is_empty = attributes[:'is_empty']
      end

      if attributes.key?(:'area')
        self.area = attributes[:'area']
      end

      if attributes.key?(:'length')
        self.length = attributes[:'length']
      end

      if attributes.key?(:'centroid')
        self.centroid = attributes[:'centroid']
      end

      if attributes.key?(:'interior_point')
        self.interior_point = attributes[:'interior_point']
      end

      if attributes.key?(:'point_on_surface')
        self.point_on_surface = attributes[:'point_on_surface']
      end

      if attributes.key?(:'dimension')
        self.dimension = attributes[:'dimension']
      end

      if attributes.key?(:'boundary')
        self.boundary = attributes[:'boundary']
      end

      if attributes.key?(:'boundary_dimension')
        self.boundary_dimension = attributes[:'boundary_dimension']
      end

      if attributes.key?(:'envelope')
        self.envelope = attributes[:'envelope']
      end

      if attributes.key?(:'envelope_internal')
        self.envelope_internal = attributes[:'envelope_internal']
      end

      if attributes.key?(:'is_rectangle')
        self.is_rectangle = attributes[:'is_rectangle']
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
          factory == o.factory &&
          user_data == o.user_data &&
          srid == o.srid &&
          geometry_type == o.geometry_type &&
          ogc_geometry_type == o.ogc_geometry_type &&
          precision_model == o.precision_model &&
          coordinate == o.coordinate &&
          coordinates == o.coordinates &&
          num_points == o.num_points &&
          num_geometries == o.num_geometries &&
          is_simple == o.is_simple &&
          is_valid == o.is_valid &&
          is_empty == o.is_empty &&
          area == o.area &&
          length == o.length &&
          centroid == o.centroid &&
          interior_point == o.interior_point &&
          point_on_surface == o.point_on_surface &&
          dimension == o.dimension &&
          boundary == o.boundary &&
          boundary_dimension == o.boundary_dimension &&
          envelope == o.envelope &&
          envelope_internal == o.envelope_internal &&
          is_rectangle == o.is_rectangle
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [factory, user_data, srid, geometry_type, ogc_geometry_type, precision_model, coordinate, coordinates, num_points, num_geometries, is_simple, is_valid, is_empty, area, length, centroid, interior_point, point_on_surface, dimension, boundary, boundary_dimension, envelope, envelope_internal, is_rectangle].hash
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
