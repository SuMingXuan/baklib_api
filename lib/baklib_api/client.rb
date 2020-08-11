module BaklibApi
  class Client
    attr_reader :request
    def initialize()
      @request = request
    end

    def request
      @client ||= Faraday.new(url: Config.host) do |conn|
        conn.headers['Authorization'] = "Bearer #{Config.token}"
        conn.headers['Content-Type'] = 'application/json'
        conn.adapter :net_http
        conn.params = {tenant_id: Config.client_id}
      end
    end

    def self.request(path, request_method = 'get', **params)
      if ['delete', 'get'].include?(request_method.to_s)
        json = params.empty? ? nil : params
      else
        json = params.empty? ? nil : params.to_json
      end
      client = Client.new
      response = client.request.send(request_method.downcase, path, json)
      # TODO 根据错误码返回对应信息
      JSON.parse(response.body)
    end
  end
end
