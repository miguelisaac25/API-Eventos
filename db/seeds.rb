puts "Apagando dados antigos..."
Registration.destroy_all
Ticket.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all

puts "Criando Roles (Papéis)..."
admin_role = Role.create!(name: "admin", description: "Administrador total do sistema")
organizer_role = Role.create!(name: "organizer", description: "Pode criar e gerenciar eventos")
participant_role = Role.create!(name: "participant", description: "Pode se inscrever em eventos")

puts "Criando Usuários..."
User.create!(
  name: "Admin Master",
  email: "admin@email.com",
  password: "password123",
  role: admin_role,
)

User.create!(
  name: "João Organizador",
  email: "organizer@email.com",
  password: "password123",
  role: organizer_role,
)

User.create!(
  name: "Maria Participante",
  email: "participant@email.com",
  password: "password123",
  role: participant_role,
)

puts "Dados criados"
puts "Use o email 'admin@email.com' e senha 'password123' para logar."
