
*** Settings ***
Resource                                      client_list_page_and_keywords.robot

*** Variables ***
${client_edit_pg_lbl}                         Edit Client
${client_edit_txtid}                          xpath=//*[@id="id"]                  
${client_edit_txtname}                        xpath=//*[@id="name"]   
${client_edit_txtemail}                       xpath=//*[@id="email"]  
${client_edit-optmale}                        xpath=///*[@id="gender:0"]
${client_edit-optfemail}                      xpath=//*[@id="gender:1"]
${client_edit-txtdsocialsecurity}             xpath=//*[@id="socialSecurityNumber"]
${client_edit-btnsave}                        xpath=//*[@id="j_idt51"]/a[1]
${client_edit_pg_button_save}                 xpath=//*[@id="j_idt51"]/a[1]

             
*** Keywords ***
Edit_client_into_wrong_email_format
    ${client_edit_current_id}=                Get value                           ${client_edit_txtid}
    ${wrong_email_format}=                    Generate Random String             8            [LOWER]
    
    Page should contain                       ${client_edit_pg_lbl} 
    Input Text                                ${client_edit_txtemail}             ${wrong_email_format}   
    Click element                             ${client_edit-btnsave}             
    
    #This test is a False-positive test. which tests if the email addrss didnt follow the the proper email format with @ inbetween
    
    Page should not contain                   Client was successfully updated.
