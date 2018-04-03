require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  movie_arr = []
  character_hash["results"].each do | char |
    if char["name"].downcase.include?(character.downcase)
      movie_arr = char["films"]
    end
  end
  return get_movie_info(movie_arr)
end

def get_movie_info(url_array)
  movie_info_arr = []
    url_array.each do |urls|
      fetch_films = RestClient.get(urls)
      movie_info_arr << JSON.parse(fetch_films)
    end
  return movie_info_arr
end

def parse_character_movies(films_hash)
  if films_hash.any?
    unsorted = []
    films_hash.each do |info|
      unsorted << info["title"]
    end
  puts "That character appears in:"
  puts unsorted.sort.join("\n")
  else
  puts 'Sorry, that character doesn’t exist in the Star Wars Universe.'
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
