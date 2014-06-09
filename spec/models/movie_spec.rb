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
      let!(:movie_two) { Movie.create(title: "The blind side", rating: "PG-13", release_date: 1.day.ago) }
      let!(:movie_one) { Movie.create(title: "Pulp fiction", rating: "NC-17", release_date: Date.today) }


      it 'orders by ascending title' do
        Movie.list(order:("title ASC")).should eq [movie_one, movie_two]
      end

      it 'orders by ascending release_date' do
        Movie.list(order:("release_date ASC")).should eq [movie_two, movie_one]
      end

      it 'orders by descending title' do
        Movie.list(order:("title DESC")).should eq [movie_two, movie_one]
      end

      it 'orders by descending release_date' do
        Movie.list(order:("release_date DESC")).should eq [movie_one, movie_two]
      end

    end
  end
end
