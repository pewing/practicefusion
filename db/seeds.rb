require 'sinatra'

def generate_doctors
  test_doctors = { "Doctor1" => { "zipcode" => "12345", "specialty" => "hearts", "rating" => 5 },
                  "Doctor2" => { "zipcode" => "12346", "specialty" => "hearts", "rating" => 5 },
                  "Doctor3" => { "zipcode" => "12345", "specialty" => "brains", "rating" => 4 },
                  "Doctor4" => { "zipcode" => "12345", "specialty" => "hearts", "rating" => 5 },
                  "Doctor5" => { "zipcode" => "12345", "specialty" => "hearts", "rating" => 4 },
                  "Doctor6" => { "zipcode" => "12340", "specialty" => "feet", "rating" => 1 }
                  }

  test_doctors.each do |name, details|
    Doctor.create(doctor_name: name,
                  zipcode: details["zipcode"],
                  specialty: details["specialty"],
                  rating: details["rating"])
  end
end

Doctor.destroy_all if Doctor.count != 0
generate_doctors()
