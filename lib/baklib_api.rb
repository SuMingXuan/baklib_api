require 'baklib_api/version'
require 'active_support/inflector'

require 'baklib_api/config'
require 'baklib_api/client'

require 'baklib_api/models/application_model'
require 'baklib_api/models/articles'
require 'baklib_api/models/channels'

module BaklibApi
  include BaklibApi::Models
end
