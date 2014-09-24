require "workxp/restfulable"

module Workxp
  class Client
  
    delegate :delete, :get, :post, :put, :request, to: :valid_token
    
    WORKXP_SITE = "https://workxp.info"
    
    include Workxp::Restfulable
    
    # OAuth2::AccessToken
    #
    # Store authorized infos
    attr_accessor :access_token
    
    # WorkXP product's subdomain. subdomain is your product's identify.
    # Your can set different subdomain for fetch different product's data.
    # @example
    # https://ruby.workxp.info 'ruby' is subdomain
    attr_accessor :sub_domain
    
    # @param [Hash] opts the options to create WorkXP Client.
    # @option opts [String] :token oauth2 access token. <required>
    # @option opts [String] :refresh_token <optional>
    # @option opts [DateTime] :expires_at <optional>
    # @option opts [String] :app_key <required>
    # @option opts [String] :app_secret <required>
    # @option opts [String] :workxp_site <optional>
    # @option opts [String] :sub_domain <optional>
    def initialize(opts={})
      @app_key = opts.delete :app_key
      @app_secret = opts.delete :app_secret
      @workxp_site = opts.delete(:workxp_site) || WORKXP_SITE
      self.sub_domain = opts.delete :sub_domain
      
      self.access_token = OAuth2::AccessToken.new(self.oauth_client, opts[:token], opts)
    end

    # OAuth2::Client instance with WorkxP OAuth
    def oauth_client
      @oauth_client ||= OAuth2::Client.new(@app_key, @app_secret, site: @workxp_site)
    end
    
    def valid_token
      if access_token.expired?
        self.access_token = access_token.refresh!
      end
      self.access_token
    end
    
    
    # @param [Hash] opts the request parameters
    # @option opts [String] :group_id Filter by group_id
    def users(opts={})
      valid_token.get('/api/users.json', params: opts, headers: domain_hash).parsed
    end
    
    def user(id)
      valid_token.get("/api/users/#{id}.json", headers: domain_hash).parsed
    end

    def groups
      valid_token.get('/api/groups.json', headers: domain_hash).parsed
    end

    restful_api "contact"
    restful_api "task"
    restful_api "note"
    restful_api "deal"
    restful_api "case"
    restful_api "category"
    
    def task_categories
      categories.select {|obj| obj['type'] == 'TaskCategory'}
    end
    
    private
    def domain_hash
      raise(ArgumentError, "WorkXP Subdomain required.") if sub_domain.nil?
      {:'Sub-Domain' => sub_domain, :'Content-Type' => 'application/json'}
    end

  end
end