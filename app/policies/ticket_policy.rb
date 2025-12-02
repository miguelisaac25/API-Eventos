class TicketPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role.name == "admin" || user.role.name == "organizer"
  end
end
