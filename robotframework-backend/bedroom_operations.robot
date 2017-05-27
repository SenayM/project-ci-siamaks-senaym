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
${get_all_bedorom_endpoint}=         /hotel-rest/webresources/bedroom
${get_bedroom_counter_endpoint}=     /hotel-rest/webresources/bedroom/count
#POST endpoints
${create_a_bedroom_endpoint}=        /hotel-rest/webresources/bedroom/
#PUT endpoints
${edit_a_bedroom_endpoint}=          /hotel-rest/webresources/bedroom/   #the id should be included
#Delete endpoint
${delete_a_bedroom_endpoint}=        /hotel-rest/webresources/bedroom/   #the id should be included

*** keywords ***

Get all bedrooms
    Create Http Context                        ${host}      ${schema}
    Get                                        ${get_all_bedroom_endpoint}
    ${response_status}=                        Get Response Status
    ${response_body}=                          Get Response Body
    Log To Console                             ${response_status}      
   # Log To Console                             ${response_body}
    Should Contain          	               ${response_status}          200
        