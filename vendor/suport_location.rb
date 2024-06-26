require 'csv'
require 'faker'
require 'geocoder'

location = [Faker::Address.latitude, Faker::Address.longitude]

def nearest(location = [], count)
  lat = location[0]
  long = location[1]

  puts "LOCATION = #{location}"
  puts "NEARESTS="

  count.times do
    location_2 = [lat + rand(0.0..0.009).round(8), long + rand(0.0..0.009).round(8)]
    d = Geocoder::Calculations.distance_between(location, location_2).round(2)

    puts "DISTANCE= #{d} KM | LOCATION=#{location_2}"
  end
end

nearest(location, 10)



# LOCATION = [30.36458931116455, -104.95409375426267]
# NEARESTS=
# DISTANCE= 0.31 KM | LOCATION=[30.36691414116455, -104.95231290426267]
# DISTANCE= 0.29 KM | LOCATION=[30.36686686116455, -104.95268404426267]
# DISTANCE= 1.15 KM | LOCATION=[30.37272580116455, -104.94677672426268]
# DISTANCE= 1.28 KM | LOCATION=[30.37354423116455, -104.94568096426268]
# DISTANCE= 0.53 KM | LOCATION=[30.36771451116455, -104.94999023426267]
# DISTANCE= 1.04 KM | LOCATION=[30.371027681164552, -104.94622691426267]
# DISTANCE= 0.74 KM | LOCATION=[30.37089761116455, -104.95148035426267]
# DISTANCE= 0.6 KM | LOCATION=[30.366989051164552, -104.94844599426267]
# DISTANCE= 0.58 KM | LOCATION=[30.36852102116455, -104.95010518426267]
# DISTANCE= 0.66 KM | LOCATION=[30.36611236116455, -104.94743328426267]
