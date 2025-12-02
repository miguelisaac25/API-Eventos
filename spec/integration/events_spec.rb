require "swagger_helper"

RSpec.describe "Events API", type: :request do
  let!(:role) { Role.find_or_create_by(name: "admin") { |r| r.description = "Admin Role" } }
  let!(:user) { User.create!(name: "Swagger Tester", email: "swagger_test@email.com", password: "password", role_id: role.id) }

  path "/events" do
    get "Listar todos os eventos" do
      tags "Events"
      produces "application/json"

      response "200", "eventos encontrados" do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              description: { type: :string },
              location: { type: :string },
              start_time: { type: :string, format: :date_time },
            },
          }

        run_test!
      end
    end

    post "Criar um evento" do
      tags "Events"
      consumes "application/json"
      security [Bearer: []]

      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: {
          event: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              start_time: { type: :string, format: :date_time },
              end_time: { type: :string, format: :date_time },
              location: { type: :string },
            },
            required: ["title", "start_time"],
          },
        },
      }

      response "201", "evento criado" do
        let(:Authorization) { "Bearer #{JsonWebTokenService.encode(user_id: user.id)}" }
        let(:event) { { event: { title: "Evento Swagger", description: "Teste", start_time: "2025-12-25T10:00:00", location: "Online" } } }
        run_test!
      end

      response "401", "não autorizado" do
        let(:Authorization) { "Bearer token_invalido" }
        let(:event) { {} }
        run_test!
      end
    end
  end
end
