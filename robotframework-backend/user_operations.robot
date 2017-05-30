*** Settings ***
Resource                             client_operations.robot
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
${get_all_user_endpoint}=            /hotel-rest/webresources/user/
${get_user_counter_endpoint}=        /hotel-rest/webresources/user/count
#POST endpoints
${create_a_user_endpoint}=           /hotel-rest/webresources/user/
#PUT endpoints
${edit_a_user_endpoint}=             /hotel-rest/webresources/user/   #the id should be included
#Delete endpoint
${delete_a_user_endpoint}=           /hotel-rest/webresources/user/   #the id should be included

*** keywords ***
Get all users
    Create Http Context                        ${host}      ${schema}
    Get                                        ${get_all_user_endpoint}
    ${response_status}=                        Get Response Status
    ${response_body}=                          Get Response Body
    Log To Console                             ${response_status}      
    #Log To Console                             ${response_body}
    Should Contain          	               ${response_status}          200

Json data for user 
    ${id}=                                     Set Variable                                  100
    ${user_login}=                             Generate Random String                        5                [LOWER]
    ${user_password}=                          Generate Random String                        4                [NUMBERS]        
    #Setting Common or Admin user
    ${user_typeUser}=                          Generate Random String                        1                   12
    ${user_clientId}=                          Json data for clientId
    ${user_userStatusId}=                      Json data for userStatusId
    ${dictionary}=                             Create Dictionary       id=${id}    login=${user_login}    password=${user_password}    typeUser=${user_typeUser}    clientId=${user_clientId}   userStatusId=${user_userStatusId}
    ${user_json}=                              Stringify Json       ${dictionary}
    [Return]                                   ${user_json}

Json data for clientId
    Create Http Context                       ${host}                 ${schema}
    Set Request Header                        Content-Type            ${header_content_json}
    Set Request Header                        Accept                  ${header_accept_all}
    ${last_id}=                               Get the id of the last client
    Get                                       ${get_all_clients_endpoint}/${last_id}/
    ${body_of_last_client}=                   Get Response Body
    ${clientId_id}=                           Get Json Value                            ${body_of_last_client}    /id
    ${clientId_name}=                         Get Json Value                            ${body_of_last_client}    /name 
    ${clientId_createDate}=                   Get Json Value                            ${body_of_last_client}    /createDate
    ${clientId_email}=                        Get Json Value                            ${body_of_last_client}    /email
    ${clientId_gender}=                       Get Json Value                            ${body_of_last_client}    /gender
    ${clientId_socialSecurityNumber}=         Get Json Value                            ${body_of_last_client}    /socialSecurityNumber
    
    ${dictionary}=                            Create Dictionary     id=${clientId_id}  name= ${clientId_name}   createDate=${clientId_createDate}  email=${clientId_email}   gender=${clientId_gender}  socialSecurityNumber=${clientId_socialSecurityNumber}
    ${clientId_user_json}=                    Stringify Json       ${dictionary}
    [Return]                                  ${dictionary}

Json data for userStatusId 
      ${user_status_id}=                      Set Variable            1
      ${user_status_code}=                    Set Variable            1
      ${user_status_name}=                    Set Variable            ACTIVE 
      
      ${dictionary}=                          Create Dictionary       id=${user_status_id}   code=${user_status_code}  name= ${user_status_name}
      ${user_statusId}=                       Stringify Json          ${dictionary}
      [Return]                                ${dictionary}

Create a user
    ${request_body}=                          Json data for user
    Create Http Context                       ${host}      ${schema}
    Set Request Header                        Content-type        ${header_content_json}
    Set Request Header                        Accept              ${header_accept_all}
    Set Request Body                          ${request_body}      
    POST                                      ${create_a_user_endpoint}   
    ${request_status}=                        Get Response Status                  
    Log to Console                            ${\n}Status code:${request_status}
    Should Contain                            ${request_status}             204

Get the id of the last user
    Create Http Context                       ${host}      ${schema}
    Get                                       ${get_all_user_endpoint}    
    ${response_status_one}=                   Get Response Status
    Should Contain                            ${response_status_one}             200
    ${body_for_all_users}=                    Get Response Body
    Get                                       ${get_user_counter_endpoint}
    ${response_status_two}=                   Get Response Status
    Should Contain                            ${response_status_two}             200
    ${users_count_body}=                      Get Response Body
    #Log to Console                           ${users_count_body}
    ${last_index}=                            Evaluate              ${users_count_body}-1
    Log to Console                            Users_LastIndex: ${last_index}
    ${lastId_user}=                           Get Json Value        ${body_for_all_users}         /${last_index}/id     
    Log to Console                            Id_of_lastUser:${lastId_user}         
    [Return]                                  ${lastId_user}

Json data for editing user credentials
    Create Http Context                       ${host}                 ${schema}
    Set Request Header                        Content-Type            ${header_content_json}
    Set Request Header                        Accept                  ${header_accept_all}
    ${last_id}=                               Get the id of the last user
    Get                                       ${get_all_user_endpoint}/${last_id}/
    ${body_of_last_user}=                     Get Response Body
    ${id}=                                    Get Json Value                  ${body_of_last_user}    /id   
    ${user_login}=                            Generate Random String          5                       [LOWER]
    ${user_password}=                         Generate Random String          4                       [NUMBERS] 
    ${user_typeUser}=                         Get Json Value                  ${body_of_last_user}    /typeUser
    ${user_clientId}=                         Json data for clientId
    ${user_userStatusId}=                     Json data for userStatusId
    ${dictionary}=                            Create Dictionary     id=${id}    login=${user_login}    password=${user_password}    typeUser=${user_typeUser}    clientId=${user_clientId}   userStatusId=${user_userStatusId}
    ${edited_user_json}=                      Stringify Json       ${dictionary}
    [Return]                                  ${edited_user_json}

Edit last user credentials
    ${id}=                                    Get the id of the last user
    ${edited_data}=                           Json data for editing user credentials
    Create Http Context                       ${host}      ${schema}
    Set Request Header                        Content-type        ${header_content_json}
    Set Request Header                        Accept              ${header_accept_all}
    Set Request Body                          ${edited_data}      
    PUT                                       ${edit_a_user_endpoint}/${id}   
    ${response_status}=                       Get Response Status                  
    #Log to Console                            ${\n}Edited_credentials_of_lastUser:${edited_data}
    Should Contain                            ${response_status}             204

Delete last user
    ${id}=                                    Get the id of the last user
    Create Http Context                       ${host}      ${schema}
    Delete                                    ${delete_a_user_endpoint}/${id}   
    ${response_status}                        Get Response Status
    Log to Console                            ${response_status}
    Should Contain                            ${response_status}             204
