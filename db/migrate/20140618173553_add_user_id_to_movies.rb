class AddUserIdToMovies < ActiveRecord::Migration
  def change
    add_reference :movies, :user, index: true

    execute("UPDATE movies SET user_id = (SELECT id FROM users LIMIT 1)")
  end
end
