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
${get_all_bedroom_endpoint}=         /hotel-rest/webresources/bedroom/
${get_bedroom_counter_endpoint}=     /hotel-rest/webresources/bedroom/count
#POST endpoints
${create_a_bedroom_endpoint}=        /hotel-rest/webresources/bedroom/
#PUT endpoints
${edit_a_bedroom_endpoint}=          /hotel-rest/webresources/bedroom/   #the id should be included
#Delete endpoint
${delete_a_bedroom_endpoint}=        /hotel-rest/webresources/bedroom/   #the id should be included

*** keywords ***


Get The ID of The Last Bedroom
    Create Http Context                        ${host}      ${schema}
    Get                                        ${get_all_bedroom_endpoint}    
    ${response_status_first_request}=          Get Response Status
    Should Contain                             ${response_status_first_request}     200
    ${body_first_request}=                     Get Response Body
 
    
    Get                                        ${get_bedroom_counter_endpoint}
    ${response_status}=                        Get Response Status
    Should Contain                             ${response_status}                                  200
    ${request_body}=                           Get Response Body
    #Log to Console                             ${request_body}
    ${last_index}=                             Evaluate              ${request_body}-1
    Log to Console                             LastIndex: ${last_index}
    ${json_id}=                                Get Json Value        ${body_first_request}         /${last_index}/id     
    Log to Console                             LastId:${json_id}         
    [Return]                                   ${json_id}

Edit last bedroom Discription
    ${id}=                                    Get The ID of The Last bedroom
    ${data}=                                  Json Data for edit bedroom Discription
    Create Http Context                       ${host}      ${schema}
    Set Request Header                        Content-type        application/json
    Set Request Header                        Accept              */*
    Set Request Body                          ${data}      
    PUT                                       ${edit_a_bedroom_endpoint}/${id}   
    ${response_status}=                       Get Response Status                  
    #Log to Console                            ${request_body}
    Log to Console                            ${\n}${data}
    Should Contain                            ${response_status}             204
    
Json Data for edit bedroom Discription
    Create Http Context              ${host}                 ${schema}
    Set Request Header               Content-Type            application/json
    Set Request Header               Accept                  */*
    ${last_id}=                               Get The ID of The Last Bedroom
    Get                                       ${get_all_bedroom_endpoint}/${last_id}/
    ${body_of_last_bedroom}=                  Get Response Body
    ${id}=                                    Get Json Value                            ${body_of_last_bedroom}    /id   
  
    ${bedroom_discription}=            Generate Random String                        8                [LOWER]
    ${bedroom_floor} =                 Get Json Value                                 ${body_of_last_bedroom}        /floor 
    ${bedroom_number} =                Get Json Value                                 ${body_of_last_bedroom}        /number
    ${bedroom_dailyprice}=             Get Json Value                                 ${body_of_last_bedroom}        /priceDaily
    ${bedroom_Status}=                 Json data for bedroom status vacant 
    ${bedroom_type}=                   Json data for bedroom type
 
    ${dictionary}=                     Create Dictionary     id=${id}  description= ${bedroom_discription}   floor=${bedroom_floor}  number=${bedroom_number}   priceDaily=${bedroom_dailyprice}  bedroomStatusId=${bedroom_Status}     typeBedroomId=${bedroom_type}
    ${edited_bedroom_json}=            Stringify Json       ${dictionary}
   
    #Log to Console                            ${edited_bedroom_json}
    [Return]                                  ${edited_bedroom_json}

Create Json data for bedroom 
    ${bedroom_discription}=            Generate Random String                        8                [LOWER]
    ${bedroom_floor} =                 Generate Random String                        1                123456789
    ${roomnumber_postfix} =            Generate Random String                        2                [NUMBERS]
    ${bedroom_number} =                Catenate      SEPARATOR=             ${bedroom_floor}          ${roomnumber_postfix}   
    ${bedroom_dailyprice}=             Generate Random String                        3                [NUMBERS]
    ${bedroom_Status}=                 Json data for bedroom status vacant 
    ${bedroom_type}=                   Json data for bedroom type
   
    ${dictionary}=                     Create Dictionary       description= ${bedroom_discription}   floor=${bedroom_floor}  number=${bedroom_number}   priceDaily=${bedroom_dailyprice}  bedroomStatusId=${bedroom_Status}     typeBedroomId=${bedroom_type}
    ${edited_bedroom_json}=            Stringify Json       ${dictionary}
    #Log to Console                     MYJSONBEDROOM${edited_bedroom_json}
    [Return]                           ${edited_bedroom_json}
   
 
 
Json data for bedroom status vacant 
      ${status_id}=                     Set Variable            1
      ${status_code}=                   Set Variable            0
      ${status_name}=                   Set Variable            VACANT 
      
      ${dictionary}=                    Create Dictionary       id=${status_id}   code=${status_code}  name= ${status_name}
      ${created_bedroom_Status}=        Stringify Json          ${dictionary}
     # Log to Console                    ${created_bedroom_Status}
      [Return]                          ${dictionary}
   
   
Json data for bedroom type
      ${type_id}=                       Set Variable            6
      ${type_name}=                     Set Variable            WHEELCHAIR ACCESS 
      
      ${dictionary}=                    Create Dictionary       id= ${type_id}   name= ${type_name}
      ${created_bedroom_type}=          Stringify Json          ${dictionary}
      #Log to Console                    ${created_bedroom_type}
      [Return]                           ${dictionary}
   
Create new vacant_classicbedking_bedroom
    ${data}=                                  Create Json data for bedroom 
    Create Http Context                       ${host}      ${schema}
    Set Request Header                        Content-type        application/json
    Set Request Header                        Accept              */*
    Set Request Body                          ${data}      
    POST                                      ${create_a_bedroom_endpoint}   
    ${request_status}=                        Get Response Status                  
    Log to Console                            ${\n}${data}
    Should Contain                            ${request_status}             204        

Get all bedrooms
    Create Http Context                        ${host}      ${schema}
    Get                                        ${get_all_bedroom_endpoint}
    ${response_status}=                        Get Response Status
    ${response_body}=                          Get Response Body
    Log To Console                             ${response_status}      
    Log To Console                             ${response_body}
    Should Contain          	               ${response_status}          200
    
    
Delete Last bedroom
    ${id}=                                    Get The ID of The Last Bedroom
    Create Http Context                       ${host}      ${schema}
    Delete                                    ${delete_a_bedroom_endpoint}/${id}   
    ${response_status}                        Get Response Status
    Log to Console                            ${response_status}
    Should Contain                            ${response_status}             204  
        