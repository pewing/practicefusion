# A site contains a listing of doctors. Users can browse for doctors given a
# specific specialty, area, review score etc.
#
# You need to help write the logic for returning similar doctors. Specifically,
# you need to write a class(es) which when given a doctor, provides a list of
# similar doctors, in a prioritized order. You define what similar means and the
# result ordering, but clearly document any assumptions in your code.
#
# Please, include unit tests. You can assume the entire directory of doctors fits
# into memory, and write in whatever language you are most comfortable with.


require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :database, {
  adapter: "sqlite3",
  database: "database.sqlite3",
  pool: 30
}

class Doctor < ActiveRecord::Base

  # returns a json of the names of all doctors that match
  def find_similar(*similarities)
    doctor_attributes = ["zipcode", "rating", "specialty"]

    # If no similarities provided, search using all similarities
    if similarities.length.eql?(0)
      similarities = doctor_attributes
    end
    # Get all except self, since it all fits in memory to reduce multiple db queries
    other_doctors = Doctor.where.not(id: self.id)

    doctor_hash = Hash.new

    similarities.each do |s|
      other_doctors.where(s.to_sym => self.send(s)).each do |d|
        # Currently only returning the doctor's name, but could just as
        # easily return the object. Depends on use of this method
        if doctor_hash.has_key?(s)
          doctor_hash[s] << d.doctor_name
        else
          doctor_hash[s] = [ d.doctor_name ]
        end
      end
    end

    doctor_hash.to_json
  end
end

# Find all doctors that share any similarity with Doctor1
get '/similar1' do
  current_doctor = Doctor.where(doctor_name: "Doctor1")[0] #assuming there's only doctor named Doctor1
  current_doctor.find_similar()
end

# Doctor2 doesn't share a zipcode with anyone
get '/similar2' do
  current_doctor = Doctor.where(doctor_name: "Doctor2")[0]
  current_doctor.find_similar("zipcode")
end

get '/similar3' do
  current_doctor = Doctor.where(doctor_name: "Doctor3")[0]
  current_doctor.find_similar("specialty", "rating")
end
