require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'carrierwave/processing/mini_magick'
require "digest/md5"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(production development test)))
end

module MongoBlog
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)

    config.time_zone = 'Beijing'

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = "zh-CN"

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    config.mongoid.include_root_in_json = false

    config.assets.enabled = true

    config.assets.version = '1.0'
  end
end
