*** Settings ***
Library                              HttpLibrary.HTTP
Library                              Collections
Library                              String
Library                              json

*** variables ***
${host}=                             localhost:8080
${schema}=                           http
${header_content_json}               application/json
${header_accept_all}                 */*         
#GET endpoints
${get_all_hotelreservation_endpoint}=         /hotel-rest/webresources/hotelreservation/
${get_hotelreservation_counter_endpoint}=     /hotel-rest/webresources/hotelreservation/count
#POST endpoints
${create_a_hotelreservation_endpoint}=        /hotel-rest/webresources/hotelreservation/
#PUT endpoints
${edit_a_hotelreservation_endpoint}=          /hotel-rest/webresources/hotelreservation/   #the id should be included
#Delete endpoint
${delete_a_hotelreservation_endpoint}=        /hotel-rest/webresources/hotelreservation/   #the id should be included

*** keywords ***

Create new new Reservation
    ${data}=                                  Json Data for hotelreservation
    Create Http Context                       ${host}      ${schema}
    Set Request Header                        Content-type        application/json
    Set Request Header                        Accept              */*
    Set Request Body                          ${data}      
    POST                                      ${create_a_hotelreservation_endpoint}   
    ${request_status}=                        Get Response Status                  
    Log to Console                            FINALDATA${\n}${data}
    Should Contain                            ${request_status}             204   

Json Data for hotelreservation
    ${entryDate}=                              Generate Random String                        8                [NUMBERS]
    ${exitDate}=                               Generate Random String                        8                [NUMBERS]
    ${priceDaily}=                             Get the last bedroom data
    ${priceDaily}=                             Get Json Value                  ${priceDaily}                 /priceDaily
   
    ${bedroomData}=	                           Get the last bedroom string data          
    ${clientData}=                             Get the last client string data
    ${reservationStatusId}=                    Reservation Status Confirmed Data
    
    ${dictionary}=                             Create Dictionary     entryDate=${entryDate}      exitDate=${exitDate}       priceDaily=${priceDaily}     bedroomId=${bedroomData}    clientId=${clientData}  reservationStatusId=${reservationStatusId}                       
    ${hotel_reservation_json_data}=            Stringify Json       ${dictionary}
   
    [Return]                                   ${hotel_reservation_json_data}
   

   
        
Reservation Status Confirmed Data
    ${id}=                                     Set Variable            1
    ${code}=                                   Set Variable            1
    ${name}=                                   Set Variable            CONFIRMED
    
    ${dictionary}=                             Create Dictionary     id=${id}  code=${code}   name=${name}  
    [Return]                                   ${dictionary}
    

Count number of Resrvations
    Create Http Context                       ${host}      ${schema}
    Get                                       ${get_hotelreservation_counter_endpoint}   
    ${response_status}                        Get Response Status
    Log to Console                            ${response_status}
    Should Contain                            ${response_status}             200  
    ${response_body}=                         Get Response Body
    Log to Console                            Number of Resrvations : ${response_body}
    
       