class ConsultationPolicy < ApplicationPolicy

  def show?
    user.lawyer == record.lawyer || user.client == record.client
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
