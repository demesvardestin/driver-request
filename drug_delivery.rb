class Driver
  def initialize
  end
  
  def create_drivers(i)
    @drivers = []
    i.times{ |x|
      @drivers << {"name" => "driver#{x}", "zip" => rand(10000..11000)}
    }
    return @drivers
  end
  
  def driver_response(req, drivers)
    r_1 = "Request accepted"
    r_2 = "Request declined"
    resp = {}
    drivers.each{ |driver|
      if self.within(req["zip"], driver["zip"]) == true
        resp = DriverResponse.new.create_dr(driver, r_1)
      else
        resp = DriverResponse.new.create_dr(driver, r_2)
      end
    }
    return resp
  end
  
  def within(x, y)
    (x + 5) > y && (x - 5) < y ? true : false
  end
end

class DriverResponse
  
  def initialize
  end
  
  def create_dr(driver, driver_response)
    d_r = {"driver" => driver, "response" => driver_response}
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
  
  def send_request(drivers)
    Driver.new.driver_response(@request, create_drivers(drivers))
  end
end

class Charge
  def initialize
    @charges = []
  end
  
  def charge_flow
    @charges << 35
    @charges
  end
end

class Patient
  def initialize
  end
  
  def create_amt(i)
    @patients = []
    i.times { |x|
      @patients << {"zip" => rand(10000..11000), "name" => "John Doe", "rx" => "Tylenol"}
    }
    return @patients
  end
end

class ProcessPatient
  
  def initialize
  end
  
  def logic_flow(patients)
    counter = 0
    charges = []
    request_response = []
    patients.map{|pat|
      counter += 1
      if counter == 10
        charges << Charge.new.charge_flow
        request_response << Request.new(pat["name"], pat["zip"]).send_request(rand(30..60))
        counter = 0
      end
    }
    return charges.flatten, request_response
  end

end
