
*** Variables ***
${bedroom_edit_pg_lbl}                    Edit Bedroom
${bedroom_edit_id}                        xpath=//*[@id="id"]
${bedroom_edit_txtdescription}            xpath=//*[@id="description"]  
${bedroom_edit-txtfloor}                  xpath=//*[@id="floor"]
${bedroom_edit-txtnumber}                 xpath=//*[@id="number"]
${bedroom_edit-txtdailyprice}             xpath=//*[@id="priceDaily"]
${bedroom_edit-lstbedroom_status}         xpath=//*[@id="bedroomStatusId"]
${edit_lstbedroom_status_busy}            xpath=//*[@id="bedroomStatusId"]/option[3]
${bedroom_edit-lstbedroom_type}           xpath=//*[@id="typeBedroomId"]
${edit_lstbedroom_type_wheelchair}        xpath=//*[@id="typeBedroomId"]/option[6]
${bedroom_edit_btnsave}                   xpath=//*[@id="j_idt50"]/a[1]


*** Keywords ***
Edit_all_bedroom_info_and_change_status_type
    
    ${bedroom_edit_current_id}=                Get value                           ${bedroom_edit_id}
    
    ${bedroom_discription}=            Generate Random String                        8                [LOWER]
    ${bedroom_floor} =                 Generate Random String                        1                 123456789
    ${roomnumber_postfix} =            Generate Random String                        2                [NUMBERS]
    ${bedroom_number} =                Catenate      SEPARATOR=             ${bedroom_floor}         ${roomnumber_postfix}   
    ${bedroom_dailyprice}=             Generate Random String                    4            [NUMBERS]
    
       
    Page should contain                ${bedroom_edit_pg_lbl} 
    Input text                         ${bedroom_edit_txtdescription}              ${bedroom_discription}
    Input text                         ${bedroom_edit-txtfloor}                  ${bedroom_floor}
    Input text                         ${bedroom_edit-txtnumber}                 ${bedroom_number}
    Input text                         ${bedroom_edit-txtdailyprice}             ${bedroom_dailyprice}
    Click element                      ${bedroom_edit-lstbedroom_status} 
    Click element                      ${edit_lstbedroom_status_busy} 
    Click element                      ${bedroom_edit-lstbedroom_type} 
    Click element                      ${edit_lstbedroom_type_wheelchair} 
    
    Click element                        ${bedroom_edit_btnsave}   
    Page should contain                  Bedroom was successfully updated
    Page should contain                  ${bedroom_edit_current_id}
    Page should contain                  ${bedroom_discription}
    Page should contain                  ${bedroom_floor}
    Page should contain                  ${bedroom_number}
    
    
    
