module BaklibApi
  module Models
    class Article < ApplicationModel
      attr_reader :id, :parent_id, :name, :identifier, :description, :ordinal, :features, :status, :slug, :visits_count, :created_at, :updated_at, :ordinal_type, :helpful_count, :unhelpful_count, :content
      def initialize(**options)
        @@attributes.each do |attr|
          instance_variable_set("@#{attr.to_s}", options[attr])
        end
      end

      def update(**options)
        path = "/api/v1/#{self.class.base_name.pluralize}/#{id}"
        attributes.delete_if { |k, v| k == :content }
        response = Client.request(path, 'put', attributes.update(options))
        self.class.new(response.dig("message").symbolize_keys)
      end
      
    end
  end
end