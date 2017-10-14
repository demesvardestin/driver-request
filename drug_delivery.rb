class Pharmacy
  
  def initialize
  end
  
  def set_pharmacy_details(pharmacy=[])
    @pharmacy = pharmacy
    sample_names = ["CVS", "Walgreens", "Rite-Aid", "Medicine Cabinet Pharmacy", "Parsons Pharmacy", "Valley Stream Pharmacy"]
    @pharmacy = {
      "name" => sample_names[rand(0..sample_names.length-1)],
      "zip" => rand(11000..11600)
    }
    return @pharmacy
  end
end
class Driver < Pharmacy
  def initialize
  end
  
  def create_drivers(i)
    @drivers = []
    i.times{ |x|
      @drivers << {"name" => "John Doe #{x}", "zip" => rand(10000..11000)}
    }
    return @drivers
  end
  
  def driver_response(req, drivers, package_id)
    r_1 = "Accepted"
    r_2 = "Declined"
    resp = {}
    drivers.each{ |driver|
      if self.within(req["zip"], driver["zip"]) == true
        resp = DriverResponse.new.create_dr(driver, r_1, package_id)
      else
        resp = DriverResponse.new.create_dr(driver, r_2)
      end
    }
    return resp
  end
  
  def within(x, y)
    (x + 75) > y && (x - 75) < y ? true : false
  end
end

class DriverResponse
  
  def initialize
  end
  
  def create_dr(driver, driver_response, package=nil)
    d_r = {"driver" => driver, "response" => driver_response, "package" => package}
    return d_r
  end
  
end

class Request < Driver
  def initialize(name=nil, zip=nil)
    @request = self.create_request(name, zip)
  end
  
  def create_request(name, zip)
    req = {
      "name" => name,
      "zip" => zip
    }
    return req
  end
  
  def send_request(package_id, drivers)
    Driver.new.driver_response(@request, create_drivers(drivers), package_id)
  end
end

class Charge
  def initialize
    @charges = []
  end
  
  def charge_flow
    @charges << 35 # this is an arbitrary number. you can choose any value you prefer
    @charges
  end
  
  def extra_mile_fee(miles)
    @charges << miles * 0.05 # this is also an arbitrary value
  end
end

class Patient < Pharmacy
  def initialize
  end
  
  def create_amt(i)
    @patients = []
    i.times { |x|
      @patients << {"zip" => rand(11000..11600), "name" => "John Doe", "rx" => "Tylenol"} # zipcodes are randomly chosen. you can set any range you prefer
    }
    return @patients
  end
end

class ProcessPatient < Pharmacy
  
  def initialize
    @pharmacy = Pharmacy.new.set_pharmacy_details
  end
  
  def logic_flow(patients, pharmacy=@pharmacy)
    counter = 0
    start = 0
    charges = []
    request_response = []
    accepted_requests = []
    patients.map{|pat|
      distance = pharmacy["zip"] - pat["zip"] # in real life, you would use a real method to calculate the distance, such as Ruby Geocoder, or the Google API
      counter += 1
      if counter % 10 == 0
        package_id = counter
        request_response << Request.new(pat["name"], pat["zip"]).send_request(package_id, rand(30..60))
        request_response.each { |req_resp|
          if req_resp["response"] == "Accepted"
            accepted_requests << req_resp
            charges << Charge.new.charge_flow
            if distance > 75
              charges << Charge.new.extra_mile_fee(distance - 75)
            end
          end
        }
        start = counter
      end
    }
    return self.format_response(charges.flatten, accepted_requests, pharmacy["name"])
  end
  
  def format_response(pharmacy_charges, accepted_requests, pharmacy_name)
    output_line = ''
    charge = nil
    surchage = nil
    i = 0
    while i < accepted_requests.length
      pharmacy_charges[i] == 35 ? charge = pharmacy_charges[i] : charge = pharmacy_charges[i + 1]
      pharmacy_charges[i + 1] != 35 ? surcharge = pharmacy_charges[i + 1] : surcharge = 0
      output_line = "There is a charge of #{charge} for #{pharmacy_name}, and a surcharge of #{surcharge}. Driver #{accepted_requests[i]["driver"]["name"]} is on the way to pick up package ##{accepted_requests[i]["package"]}. \n"
      charge = nil
      surcharge = nil
      print output_line
      i += 1
    end
    total_charges = pharmacy_charges.reduce(0){|sum, charge| sum += charge}
    print "Total charges are #{total_charges}."
  end

end