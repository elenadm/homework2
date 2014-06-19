class MoviePolicy < Struct.new(:user, :movie)
  def show?
    user.admin? || !movie.draft?
    true
  end

  def create?
    user.admin?
    true
  end

  alias_method :new?, :create?

  def update?
    user.admin? || user == movie.user
    true
  end

  alias_method :edit?, :update?
end