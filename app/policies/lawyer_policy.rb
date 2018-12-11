class LawyerPolicy < ApplicationPolicy
  def index?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
