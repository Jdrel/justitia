class ConsultationPolicy < ApplicationPolicy
  def index?
    user.lawyer == record.lawyer
  end

  def show?
    user.lawyer == record.lawyer || user.client == record.client
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
