class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :rating, presence: true,
            inclusion: {in: ['G', 'PG', 'PG-13', 'R', 'NC-17'], allow_blank: true}
  validates :release_date, presence: {message: "looks bad"}


  mount_uploader :avatar, AvatarUploader
  scope :list, ->(options) {
    res = all
    res = res.where(rating: options[:rating]) if options.key? :rating
    res = res.order(options[:order]) if options.key? :order
    res
  }

  def self.all_available_ratings
    ['G', 'PG', 'PG-13', 'R', 'NC-17']
  end

  def self.all_ratings
    Movie.select('rating').distinct.order(:rating).pluck(:rating)
  end
end
