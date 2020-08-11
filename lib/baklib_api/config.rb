module BaklibApi
  # baklib配置模块
  module Config
    # token是每个用户的唯一标识，且token为必填
    mattr_accessor :token

    # 每个站点的唯一标识，且client_id 为必填
    mattr_accessor :client_id
    mattr_reader :tenant_id

    mattr_reader :host
    @@host = 'https://www.baklib.com/'

    def self.setup
      yield self
      @@tenant_id = client_id
    end
  end
end
