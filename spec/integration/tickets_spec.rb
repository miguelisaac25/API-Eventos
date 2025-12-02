require "swagger_helper"

RSpec.describe "Tickets API", type: :request do
  let!(:role) { Role.find_or_create_by(name: "admin") { |r| r.description = "Admin" } }
  let!(:user) { User.create!(name: "Admin User", email: "admin_ticket@test.com", password: "password", role_id: role.id) }
  let!(:event) { Event.create!(title: "Evento Teste", description: "Desc", start_time: Time.now, end_time: Time.now + 2.hours, location: "Web", user: user) }

  path "/tickets" do
    get "Listar ingressos" do
      tags "Tickets"
      produces "application/json"

      response "200", "ingressos encontrados" do
        run_test!
      end
    end

    post "Criar ingresso" do
      tags "Tickets"
      consumes "application/json"
      security [Bearer: []]

      parameter name: :ticket, in: :body, schema: {
        type: :object,
        properties: {
          ticket: {
            type: :object,
            properties: {
              name: { type: :string },
              price: { type: :number },
              quantity: { type: :integer },
              event_id: { type: :integer },
            },
            required: ["name", "price", "event_id"],
          },
        },
      }

      response "201", "ingresso criado" do
        let(:Authorization) { "Bearer #{JsonWebTokenService.encode(user_id: user.id)}" }
        let(:ticket) { { ticket: { name: "VIP", price: 100.0, quantity: 50, event_id: event.id } } }
        run_test!
      end
    end
  end
end
