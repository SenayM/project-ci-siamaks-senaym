*** Settings ***
Resource                                    bedroom_list_page_and_keywords.robot
Library                                     Collections
*** Variables ***
${bedroom_create_pg_lbl}                    Create New Bedroom
${bedroom_create_txtdescription}            xpath=//*[@id="description"] 
${bedroom_create-txtfloor}                  xpath=//*[@id="floor"]
${bedroom_create-txtnumber}                 xpath=//*[@id="number"]
${bedroom_create-txtdailyprice}             xpath=//*[@id="priceDaily"]
${bedroom_create-lstbedroom_status}         xpath=//*[@id="bedroomStatusId"]
${lstbedroom_status_vacant}                 xpath=//*[@id="bedroomStatusId"]/option[2]
${bedroom_create-lstbedroom_type}           xpath=//*[@id="typeBedroomId"]
${lstbedroom_type_clasicbedking}            xpath=//*[@id="typeBedroomId"]/option[2]
${bedroom_create-btnsave}                   xpath=//*[@id="saveBtn"]

*** Keywords ***
Create_new_vacant_classicbedking_bedroom
    ${bedroom_discription}=            Generate Random String                        8                [LOWER]
    ${bedroom_floor} =                 Generate Random String                        1                123456789
    ${roomnumber_postfix} =            Generate Random String                        2                [NUMBERS]
    ${bedroom_number} =                Catenate      SEPARATOR=             ${bedroom_floor}          ${roomnumber_postfix}   
    ${bedroom_dailyprice}=             Generate Random String                        4                [NUMBERS]
    
   
    
    Page should contain                ${bedroom_create_pg_lbl} 
    Input text                         ${bedroom_create_txtdescription}            ${bedroom_discription}
    Input text                         ${bedroom_create-txtfloor}                  ${bedroom_floor}
    Input text                         ${bedroom_create-txtnumber}                 ${bedroom_number}
    Input text                         ${bedroom_create-txtdailyprice}             ${bedroom_dailyprice}
    Click element                      ${bedroom_create-lstbedroom_status} 
    Click element                      ${lstbedroom_status_vacant} 
    Click element                      ${bedroom_create-lstbedroom_type} 
    Click element                      ${lstbedroom_type_clasicbedking} 
    Click element                      ${bedroom_create-btnsave}  
    Page should contain                Bedroom was successfully created.
    