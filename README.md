I've recently begun to code in ruby, so I've been trying to hone my skills a bit. 
This is a very basic implementation (or my idea of an implementation) of a 
pharmacy-to-driver request for prescription delivery. I'll be actively trying to 
make it better as I learn more.

To try it out:

1. create a new instance of the Patient class in order to initiate an array of a
number of patients.
2. create a new instance of the ProcessPatient class in order to process a new 
request to drivers, while also creating charges for the pharmacy.

Ex:

patients = Patient.new.create_amt(20)
process = ProcessPatient.new.logic_flow(patients)
puts process

##This would return the following:
##[[35, 35], [{"driver"=>{"name"=>"driver48", "zip"=>10438}, "response"=>"Request declined"}, {"driver"=>{"name"=>"driver48", "zip"=>10818}, "response"=>"Request accepted"}]]


Note: I set up some arbitrary numbers like 35 ($35), which is the amount a 
pharmacy gets charged for every 10 patients processed. 10 is the set amount of 
prescriptions that a driver picks up from a pharmacy to deliver.

The final values that get returned are the charges, and an array of hashes 
containing the driver's name and their response to the request.


