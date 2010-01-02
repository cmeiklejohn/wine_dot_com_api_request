class WineDotComApiRequest
  public
    # Required API parameters.
    attr_accessor         :api_key, :api_version, :api_format, :api_resource, :api_parameters, :api_base_url

    # Optional search criteria.
    attr_accessor         :search_offset, :search_size, :search_search, :search_filter, :search_state, :search_sort, :search_instock 

    # Inialize the required parameters, and setup the request.
    def initialize
      @api_key =          ""
      @api_version =      "2.3"                                     # Available API versions: 1.0, 2.3
      @api_format =       "xml"                                     # Available API formats: xml, json
      @api_resource =     "catalog"                                 # Available API resources: catalog, reference, categorymap
      @api_parameters =   ""
      @api_affiliate_id = ""

      @api_base_url =     "http://services.wine.com/api/beta/service.svc"
    end

    # Return URL that request will be made to.
    def url
      api_url
    end

  private
    # Perform GET request and return results.
    def do_get
      res = Net::HTTP.get(URI.parse(api_url))
      puts res
    end
  
    # Generate the url to make the api call to.
    def api_url
      "#{api_base_url}/#{api_format}/#{api_resource}?apikey=#{api_key}#{api_parameters}"
    end

    # api_parameters overrides attribute reader and returns custom results based on resource type.
    def api_parameters
      url_params = ""

      if @api_resource == "catalog"
        url_params += "&" + "offset=#{@search_offset}"   if @search_offset
        url_params += "&" + "size=#{@search_size}"       if @search_size
        url_params += "&" + "search=#{@search_search}"   if @search_search
        url_params += "&" + "filter=#{@search_filter}"   if @search_filter
        url_params += "&" + "state=#{@search_state}"     if @search_state
        url_params += "&" + "sort=#{@search_sort}"       if @search_sort
        url_params += "&" + "instock=#{@search_instock}" if @search_instock
      elsif @api_resource == "categorymap"
        url_params += "&" + "filter=#{@search_filter}"   if @search_filter
        url_params += "&" + "search=#{@search_search}"   if @search_search
      elsif @api_resource == "reference"
        url_params += "&" + "filter=#{@search_filter}"   if @search_filter
      end

      return url_params
    end
end