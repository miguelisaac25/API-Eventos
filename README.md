# 📅 API de Gestão de Eventos

## 📋 Funcionalidades

- 🔐 **Autenticação:** JWT (HS256) manual (sem Devise), com expiração configurada.
- 🛡 **Autorização:** Uso da gem `pundit` com três papéis definidos:
  - **Admin:** acesso total ao sistema.
  - **Organizer:** pode criar eventos e gerenciar ingressos.
  - **Participant:** pode visualizar eventos e se inscrever.
- 📄 **CRUD Completo:** Entidades `User`, `Role`, `Event`, `Ticket`, `Registration`.
- 📬 **Notificações:** Envio de e-mail transacional automático (via `letter_opener` no ambiente dev).
- 📚 **Documentação:** OpenAPI utilizando Swagger via `rswag`.

---

## 🛠 Tecnologias Utilizadas

| Categoria | Recursos |
|----------|-----------|
| Linguagem | Ruby 3.x |
| Framework | Rails 8.0.4 (modo API) |
| Banco de Dados | PostgreSQL |
| Autenticação | JWT |
| Autorização | Pundit |
| Documentação | Rswag / Swagger |

### 📦 Gems Principais
- `jwt`
- `pundit`
- `rswag`
- `rack-cors`
- `letter_opener`

---

## 🚀 Instalação e Execução

### 1. Pré-requisitos
- Ruby 3.0+
- Rails 8
- PostgreSQL
- Git

### 2. Clonar o projeto

```bash
git clone [[https://github.com/SEU_USUARIO/events_api.git](https://github.com/miguelisaac25/API-Eventos.git)]
cd events_api
```
### 3. Intalar dependências
```bash
bundle install
```
### 4. Configurar banco de dados
```bash
rails db:setup
```
### 5. Configurar variáveis de ambiente
Crie um arquivo .env na raiz do projeto:
```
JWT_SECRET=minha_chave_super_secreta_123
```
### 6. Executar o servidor
```bash
rails server
```
A API estará disponível em: http://localhost:3000

📖 Documentação da API (Swagger)

http://localhost:3000/api-docs

### Como autenticar no Swagger:
1. Vá até a rota `POST /auth/login`
2. Faça login com um dos usuários padrão (veja abaixo)
3. Copie o token retornado.
4. Clique no botão Authorize (cadeado).
5. Cole no formato:
```
  Bearer SEU_TOKEN_AQUI
```
### 🧪 Testes
```bash
bundle exec rspec spec/integration
```
## 👤 Usuários Padrão (Seeds)

| **Role**      | **Email**             | **Senha**      | **Permissões**                |
|---------------|------------------------|----------------|-------------------------------|
| **Admin**     | admin@email.com       | password123    | Acesso total                  |
| **Organizer** | organizer@email.com   | password123    | Cria eventos e ingressos      |
| **Participant** | participant@email.com | password123  | Visualiza e se inscreve       |

## 📝 Licença
Projeto desenvolvido para fins acadêmicos no IFPR.

