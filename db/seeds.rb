('a'..'e').each do |c|
  user = User.new
  user.email = "#{c}@#{c}#{c}.com"
  user.admin = [false, true].sample
  user.update_password("123")

  ['Escape', 'Starting', 'Something'].each do |f|
    movie = Movie.new
    movie.title = "#{f}_#{c}"
    movie.rating = ['G', 'PG', 'PG-13', 'R', 'NC-17'].sample
    movie.release_date = Time.now
    movie.published = [true, true, false].sample
    movie.user_id = user.id
    movie.save
  end
end
User.first.update(admin: true)

