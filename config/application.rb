require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KaladingQa
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = Rails.env

    config.active_record.raise_in_transactional_callbacks = true

    config.eager_load_paths += %W[#{config.root}/lib/api_clients]

    # https://wjp2013.github.io/rails/Auto-loading-lib-files-in-Rails-4/
    # config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    # config.eager_load_paths += Dir[Rails.root.join('app', 'api', '*')]

    config.middleware.use(Rack::Config) do |env| # 支持 grape-jbuilder
      env['api.tilt.root'] = Rails.root.join 'app', 'api'
    end

    config.generators do |g|
      g.orm :active_record
      g.view_specs      false
      g.helper_specs    false
    end

    config.active_support.test_order = :random
  end
end
