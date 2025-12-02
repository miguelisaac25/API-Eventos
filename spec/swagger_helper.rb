require "rails_helper"

RSpec.configure do |config|
  config.swagger_root = Rails.root.join("swagger").to_s

  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "API de Eventos - Final",
        version: "v1",
        description: "API desenvolvida para a disciplina de Web III com Rails 8",
      },
      paths: {},
      servers: [
        {
          url: "http://localhost:3000",
          description: "Servidor Local",
        },
      ],
      components: {
        securitySchemes: {
          Bearer: {
            type: :apiKey,
            name: "Authorization",
            in: :header,
            description: "Token JWT. Exemplo: Bearer eyJhbGciOiJIUz...",
          },
        },
      },
    },
  }

  config.swagger_format = :yaml
end
