class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role.name == "admin" || user.role.name == "organizer"
  end

  def update?
    user.role.name == "admin" || record.user_id == user.id
  end

  def destroy?
    user.role.name == "admin" || record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
