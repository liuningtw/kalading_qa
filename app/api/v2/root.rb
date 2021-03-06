# require 'grape-swagger'

module V2
  class Root < Grape::API
    helpers V2::Helpers

    version 'v2'
    format :json
    content_type :json, "application/json;charset=UTF-8"
    formatter :json, Grape::Formatter::Jbuilder

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    mount V2::Tags
    mount V2::Questions
    mount V2::Answers
    mount V2::ReplierSummaries

    add_swagger_documentation base_path: "/api",
                              api_version: 'v2',
                              mount_path: 'doc',
                              hide_documentation_path: true,
                              markdown: GrapeSwagger::Markdown::KramdownAdapter
  end
end
