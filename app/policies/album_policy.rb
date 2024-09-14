# frozen_string_literal: true

class AlbumPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    record.created_by.present? && (user == record.created_by) && !record.published?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def publish?
    edit?
  end

  class Scope < Scope
    def resolve
      return scope.published if user.blank?

      scope.where(created_by_id: user.id)
    end
  end
end
