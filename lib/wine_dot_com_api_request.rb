#!/usr/bin/ruby

# WineDotComApiRequest class.  
#
# Provides an interface to access the Wine.com API.
# 
# Author:: Christopher Meiklejohn (cmeik@me.com)
# Copyright:: Copyright (c) 2010 Christopher Meiklejohn
# License:: Distributes under the terms specified in the MIT-LICENSE file.
#
# Usage example: 
#w = WineDotComApiRequest.new(:search => 'mondavi cabernet',
#                             :format => :xml,
#                             :resource => :catalog,
#                             :size => 1,
#                             :offset => 0)
#
# w.query
#
# To-do: 
# * Build a better interface for filters 
# * Build a better interface for sortBy
# * Implement affiliateId
# * Implement version, beta currently only supported
# * Extract out api key and base url into configuration parameters
#
# See: http://api.wine.com/wiki/2-catalog-queries
require "wine_dot_com_api_request/configuration"
require 'net/http'
require 'uri'

class WineDotComApiRequest
  public
    # API key from Wine.com.
    attr_accessor         :api_key
    
    # API version number.  Available API versions: v1.0, v2.3.
    attr_accessor         :version
    
    # API result format.  Available API formats: xml, json.
    attr_accessor         :format
    
    # API requested resource.  Available API resources: catalog, reference, categorymap.
    attr_accessor         :resource
    
    # API parameters. 
    attr_accessor         :parameters
    
    # Base URL of API.
    attr_accessor         :base_url
    
    # Affiliate ID for revenue sharing.
    attr_accessor         :affiliate_id

    # Search offset to start at.
    attr_accessor         :offset
    
    # Number of records to return.
    attr_accessor         :size
    
    # Search terms.
    attr_accessor         :search
    
    # Search filter.  Ex. filter=categories(7155+124)+rating(85|100).
    attr_accessor         :filter
    
    # Ship to state.  Two letter abbrev.  Ex. MA.
    attr_accessor         :state
    
    # Sort key.  Ex. sort=rating|ascending.
    attr_accessor         :sort
    
    # In stock.  Boolean search value.
    attr_accessor         :instock

    # Inialize the required parameters, and setup the request defaults.
    def initialize(options = {})
      options.each_pair do |key, value|
        self.send("#{key}=", value)
      end
    end

    # Return URL that request will be made to.  Mainly for debugging purposes.
    def url
      api_url
    end
    
    # Execute a search.  Returns either raw json or xml.
    def query(options = {})
      options.each_pair do |key, value|
        self.send("#{key}=", value)
      end
      
      raise 'No API base URL provided.' unless @@base_url
      raise 'No API key provided.' unless @@api_key
      raise 'No resource specified.' unless @resource
      raise 'No format specified.' unless @format
      
      return do_get
    end

  private
    # Perform GET request and return results.
    def do_get
      Net::HTTP.get(URI.parse(api_url))
    end
  
    # Generate the url to make the API call to.
    def api_url
      "#{@@base_url}/#{format}/#{resource}?apikey=#{@@api_key}#{parameters}"
    end

    # parameters overrides attribute reader and returns custom results based on resource type.
    def parameters
      url_params = ""

      if @resource == :catalog
        url_params += "&" + "offset=#{URI.escape(@offset.to_s)}"   if @offset
        url_params += "&" + "size=#{URI.escape(@size.to_s)}"       if @size
        url_params += "&" + "search=#{URI.escape(@search)}"        if @search
        url_params += "&" + "filter=#{URI.escape(@filter)}"        if @filter
        url_params += "&" + "state=#{URI.escape(@state)}"          if @state
        url_params += "&" + "sort=#{URI.escape(@sort)}"            if @sort
        url_params += "&" + "instock=#{@instock}"                  if @instock
      elsif @resource == :categorymap
        url_params += "&" + "filter=#{URI.escape(@filter)}"        if @filter
        url_params += "&" + "search=#{URI.escape(@search)}"        if @search
      elsif @resource == :reference
        url_params += "&" + "filter=#{URI.escape(@filter)}"        if @filter
      end

      return url_params
    end
end