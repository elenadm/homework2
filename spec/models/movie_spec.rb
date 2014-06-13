require 'spec_helper'

describe Movie do
  describe Movie do
    context ".all_ratings" do
      it 'No movies - no ratings' do
        expect(Movie.all_ratings).to eq([])
      end

      it 'One movie - one rating' do
        Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
        expect(Movie.all_ratings).to eq(['R'])
      end

      it 'Another movie - another rating' do
        Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
        expect(Movie.all_ratings).to eq(['PG'])
      end

      it 'Two movies - two ratings' do
        Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
        Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
        expect(Movie.all_ratings).to eq(['PG', 'R'])
      end

      it 'No duplicates' do
        Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
        Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
        expect(Movie.all_ratings).to eq(['PG'])
      end
    end

    context ".all_available_ratings" do
      it 'Rating for list - ratings' do
        expect(Movie.all_available_ratings).to eq(['G', 'PG', 'PG-13', 'R', 'NC-17'])
      end
    end

    context ":list" do
      let!(:movie_one) { Movie.create(title: "Pulp fiction", rating: "NC-17", release_date: Date.today) }
      let!(:movie_two) { Movie.create(title: "The blind side", rating: "PG-13", release_date: 1.day.ago) }

      it 'Orders by ascending title' do
        Movie.list(order: ("title ASC")).should eq [movie_one, movie_two]
      end

      it 'Orders by ascending release_date' do
        Movie.list(order: ("release_date ASC")).should eq [movie_two, movie_one]
      end

      it 'Orders by descending title' do
        Movie.list(order: ("title DESC")).should eq [movie_two, movie_one]
      end

      it 'Orders by descending release_date' do
        Movie.list(order: ("release_date DESC")).should eq [movie_one, movie_two]
      end

      it 'No ratings - no movies' do
        Movie.list(rating: ['R']).should eq []
      end

      it 'One rating' do
        Movie.list(rating: ['NC-17']).should eq [movie_one]
      end

      it 'Two ratings of list' do
        Movie.list(rating: ['G', 'PG', 'PG-13', 'R', 'NC-17']).should eq [movie_one, movie_two]
      end

      it 'Orders with ratings' do
        Movie.list(rating: ['G', 'PG', 'PG-13', 'R', 'NC-17'], order: ("title DESC")).should eq [movie_two, movie_one]
      end
    end

    context "validates" do
      before(:each) do
        @movie_test = Movie.create(title: "Pulp fiction", rating: "NC-17", release_date: Date.today, description: 'The lives of two mob hit men, a boxer, a gangster wife, and a pair of diner bandits intertwine in four tales of violence and redemption.')
      end
      it "is valid with valid attributes" do
        @movie_test.should be_valid
      end

      it "is not valid without a title" do
        @movie_test.title = nil
        @movie_test.should_not be_valid
      end

      it "is not valid without a rating" do
        @movie_test.rating = nil
        @movie_test.should_not be_valid
      end

      it "is not valid without a list rating" do
        @movie_test.rating = 'P'
        @movie_test.errors_on(:rating).should include("is not included in the list")
        @movie_test.should_not be_valid
      end

      it "is not valid without a release_date" do
        @movie_test.release_date = nil
        @movie_test.errors_on(:release_date).should include("looks bad")
        @movie_test.should_not be_valid
      end

      it "is not valid without format date for release_date" do
        @movie_test.release_date = 'today'
        @movie_test.errors_on(:release_date).should include("looks bad")
        @movie_test.should_not be_valid
      end
    end
  end
end
