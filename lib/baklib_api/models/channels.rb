module BaklibApi
  module Models
    class Channel < ApplicationModel
      
      attr_reader :id, :parent_id, :name, :identifier, :description, :ordinal, :features, :status, :slug, :visits_count, :created_at, :updated_at, :ordinal_type
      def initialize(**options)
        @@attributes.each do |attr|
          instance_variable_set("@#{attr.to_s}", options[attr])
        end
      end

      def articles
        Article.list(channel_id: id)
      end

      def create_article(**options)
        Article.create(options.merge(channel_id: id))
      end

    end
  end
end