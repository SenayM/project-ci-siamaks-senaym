*** Settings ***
Resource     bedroom_operations.robot
Resource     client_operations.robot
Resource     user_operations.robot
Resource     reservation_operations.robot

*** Test cases ***

 Test Case 1 - Create Bedroom
      Create new vacant_classicbedking_bedroom
   
 Test Case 2 - Get All Bedrooms
     Get all bedrooms
    
 Test Case 3 - Edit last bedroom Discription
      Edit last bedroom Discription  
     
 Test Case 4 - Delete Last Bedroom
      Delete Last bedroom






 Test Case 6 - Create User
     Create a client
     Create a user

 Test Case 7 - Get All Users
     Get all users

 Test Case 8 - Edit Last User
     Edit last user login

 Test Case 9 - Delete Last User
     Delete last user
      
 Test Case 10 - Create Reservation
      #Befor running reservation test make sure you run create clients 
     Create a client 
     Create new vacant_classicbedking_bedroom
     Create new new Reservation
    
 Test Case 11 - Count number of Resrvations
     Count number of Resrvations
 
 
 
    