require "swagger_helper"

RSpec.describe "Registrations API", type: :request do
  let!(:role) { Role.find_or_create_by(name: "participant") { |r| r.description = "Part" } }
  let!(:admin_role) { Role.find_or_create_by(name: "admin") }
  let!(:admin) { User.create!(name: "Admin", email: "admin_reg@test.com", password: "password", role_id: admin_role.id) }
  let!(:user) { User.create!(name: "Part User", email: "part_reg@test.com", password: "password", role_id: role.id) }

  let!(:event) { Event.create!(title: "Evento Reg", description: "Desc", start_time: Time.now, location: "Web", user: admin) }
  let!(:ticket) { Ticket.create!(name: "Geral", price: 0, quantity: 100, event: event) }

  path "/registrations" do
    get "Listar inscrições" do
      tags "Registrations"
      produces "application/json"
      security [Bearer: []]

      response "200", "inscrições encontradas" do
        let(:Authorization) { "Bearer #{JsonWebTokenService.encode(user_id: user.id)}" }
        run_test!
      end
    end

    post "Realizar inscrição" do
      tags "Registrations"
      consumes "application/json"
      security [Bearer: []]

      parameter name: :registration, in: :body, schema: {
        type: :object,
        properties: {
          registration: {
            type: :object,
            properties: {
              status: { type: :string },
              ticket_id: { type: :integer },
            },
            required: ["ticket_id"],
          },
        },
      }

      response "201", "inscrição realizada" do
        let(:Authorization) { "Bearer #{JsonWebTokenService.encode(user_id: user.id)}" }
        let(:registration) { { registration: { status: "confirmed", ticket_id: ticket.id } } }
        run_test!
      end
    end
  end
end
