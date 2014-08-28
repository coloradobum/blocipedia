class WikiPolicy < ApplicationPolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present?
        scope.all
      else
        # scope.where(:public => true)
        scope.all
      end
    end

  end

    def index?

    end

    def edit?
      show?
    end

    def update?
      show?
    end

    def show?
      record.user == user || record.private == false || Wiki.is_wiki_collaborator(user, record.id)
      
    end
end
