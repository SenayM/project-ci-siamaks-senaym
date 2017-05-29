*** Settings ***
Library                              HttpLibrary.HTTP
Library                              Collections
Library                              String
Library                              json

*** variables ***
${http_context}=                     localhost:8080
${http_variable}=                    http
${header_content_json}               application/json
${header_accept_all}                 */*         
#GET endpoints
${get_all_clients_endpoint}=         /hotel-rest/webresources/client/
${get_clients_counter_endpoint}=     /hotel-rest/webresources/client/count
#POST endpoints
${create_a_client_endpoint}=         /hotel-rest/webresources/client/
#PUT endpoints
${edit_a_client_endpoint}=           /hotel-rest/webresources/client/   #the id should be included
#Delete endpoint
${delete_a_client_endpoint}=         /hotel-rest/webresources/client/   #the id should be included

*** keywords ***
Generate a random client
    ${id}=                           Set Variable                   100
    ${name}=                         Generate random String         10                  [LOWER]
    ${createDate}=                   Set Variable                   1473633063279
    ${email}=                        Catenate                       SEPARATOR=          ${name}        @email.com
    ${socialSecurityNumber}=         Generate Random String         9                   [NUMBERS]
    ${gender}=                       Generate Random String         1                   MF
    ${dictionary}=                   Create Dictionary  id=${id}    name=${name}  createDate=${createDate}   email=${email}   gender=${gender}   socialSecurityNumber=${socialSecurityNumber}
    ${client_json}=                  Stringify Json                 ${dictionary}
    [return]                         ${client_json}
    

## Method using the GET   /webresources/client/count
Get the total of clients                      
    Create Http Context              ${http_context}     ${http_variable}     
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}
    HttpLibrary.HTTP.GET             ${get_clients_counter_endpoint}    
    ${response_status}=              Get response Status
    ${total_clients}=                Get response body      
    log to console                   ${\n}Getting the total of clients:${total_clients}
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      200 
    #log to console                   ${total_clients}
    [Return]                         ${total_clients}             

## Method using  POST  /webresources/client/count
Create a client    
    ${request_body} =                Generate a random client
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}        
    Set request body                 ${request_body}        
    Log to console                   ${\n}Creating a new client${\n}DATA:${request_body}    
    HttpLibrary.HTTP.POST            ${create_a_client_endpoint}
    ${response_status}=              Get response Status    
    log to console                   ${\n}Status code:${response_status}  
    Should contain                   ${response_status}	                      204

Get the id of the last client
    Create Http Context              ${host}      ${schema}
    Get                              ${get_all_clients_endpoint}    
    ${response_status_one}=          Get Response Status
    Should Contain                   ${response_status_one}                   200
    ${body_for_all_clients}=         Get Response Body
    Get                              ${get_clients_counter_endpoint}
    ${response_status_two}=          Get Response Status
    Should Contain                   ${response_status_two}                   200
    ${clients_count_body}=           Get Response Body
    #Log to Console                  ${request_body}
    ${last_index}=                   Evaluate              ${clients_count_body}-1
    Log to Console                   Clients_LastIndex: ${last_index}
    ${lastId_client}=                Get Json Value        ${body_for_all_clients}         /${last_index}/id     
    Log to Console                   Id_of_lastClient:${lastId_client}         
    [Return]                         ${lastId_client} 

        