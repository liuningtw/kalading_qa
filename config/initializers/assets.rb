Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w(
                                                  api/api.js
                                                  api/api.css

                                                  admins/admin.js
                                                  admins/admin.css
                                                )
