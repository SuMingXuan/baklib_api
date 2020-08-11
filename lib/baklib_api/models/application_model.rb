module BaklibApi
  module Models
    class ApplicationModel

      def self.inherited(subcalss)
        subcalss.class_eval do 
          def attributes
            h = {}
            self.class.class_variable_get("@@attributes").each do |attr|
              h[attr] = send(attr)
            end
            h
          end

          # 删除
          def destroy
            path = "/api/v1/#{self.class.base_name.pluralize}/#{id}"
            response = Client.request(path, 'delete', attributes)
            self
          end

          # 修改
          def update(**options)
            path = "/api/v1/#{self.class.base_name.pluralize}/#{id}"
            response = Client.request(path, 'put', attributes.update(options))
            self.class.new(response.dig("message").symbolize_keys)
          end

        end

        subcalss.instance_eval do
          # TODO 如果attr_reader 换行则只会记录最后一个
          def attr_reader(*args)
            self.class_variable_set("@@attributes", args)
            super
          end

          def base_name
            self.to_s.downcase.split('::').last
          end

          # 列表页面
          def list(**options)
            params = {
              _page: 1, 
              _per_page: nil
            }.update(options)
            path = "/api/v1/#{base_name.pluralize}/"
            response = Client.request(path, 'get', params)
            items = response.dig('message', 'items')
            arr = []
            items.each do |item|
              arr << new(item.symbolize_keys)
            end
            arr
          end

          # 创建
          def self.create(**options)
            path = "/api/v1/#{base_name.pluralize}/"
            response = Client.request(path, 'post', options)
            new(response.dig("message").symbolize_keys)
          end

        end
      end
    end
  end
end