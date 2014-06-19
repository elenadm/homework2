class MoviePolicy < Struct.new(:user, :movie)
  def show?
    user.admin? || user.id == movie.user.id || movie.published?
  end

  def create?
    user.admin?
    true
  end

  alias_method :new?, :create?

  def update?
    user.admin? || user.id == movie.user.id
  end

  def publication?
    user.admin?
  end

  alias_method :edit?, :update?
end