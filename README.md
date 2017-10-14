I've recently begun to code in ruby, so I've been trying to hone my skills a bit. 
This is a very basic implementation (or my idea of an implementation) of a 
pharmacy-to-driver request for prescription delivery. The program takes in a certain 
number of patients for which it creates some prescriptions. It will then send 
out requests for drivers in the area to come pick up the medications. It will 
output the charge, surcharge, driver name and package number for every accepted 
request. I'll be actively trying to improve the code and its objectives as I learn more.

To try it out:

1. create a new instance of the Patient class in order to initiate an array of a
number of patients.
2. create a new instance of the ProcessPatient class in order to process a new 
request to drivers, while also creating charges for the pharmacy.

Ex:

patients = Patient.new.create_amt(20)
process = ProcessPatient.new.logic_flow(patients)

##Would return:
##There is a charge of 35 for Valley Stream Pharmacy, and a surcharge of 16.8. Driver John Doe 43 is on the way to pick up package #40. There is a charge of 35 for Valley Stream Pharmacy, and a surcharge of 0. Driver John Doe 43 is on the way to pick up package #40. Total charges are 86.8.


Note: I set up some arbitrary numbers like 35 ($35), which is the amount a 
pharmacy gets charged for every 10 patients processed. 10 is the set amount of 
prescriptions in a single package. A surcharge is the amount charged for every 
mile that exceeds the delivery distance radius.

Your feedback is appreciated.


