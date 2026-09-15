class CustomerPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    user.admin?
  end
end

