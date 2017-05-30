*** Settings ***
Resource                                  client_list_page_and_keywords.robot
Library                                   Collections

*** Variables ***
${client_pg_label_on_page_create}                      Create New Client
${client_create_pg_button_showall}                     xpath=//*[@id="j_idt52"]/a[2]
${client_create_pg_button_save}                        xpath=//*[@id="j_idt52"]/a[1]
${client_create_nameFiled}                             xpath=//*[@id="name"]
${client_create_emailField}                            xpath=//*[@id="email"]
${client_create_SSNumberField}                         xpath=//*[@id="socialSecurityNumber"]

*** Keywords ***
create_new_client_and_verify
    ${client_name}=                    Generate Random String                        5                [LOWER]
    ${client_userEmail}=               Generate Random String                        5                [LOWER]
    ${client_email}=                   Catenate      SEPARATOR=               ${client_userEmail}     @email.com  
    ${client_SSNumber}=                Generate Random String                        6                [NUMBERS]
    ${client_gender}=                  Generate Random String                        1                01
    #Randomly chooses Male or Female
    ${client_gender_xpath}=            Catenate      SEPARATOR=                xpath=//*[@id="gender:  ${client_gender}  "]
    
    Page should contain                ${client_pg_label_on_page_create} 
    Input text                         ${client_create_nameFiled}                  ${client_name}
    Input text                         ${client_create_emailField}                 ${client_email}
    Click element                      ${client_gender_xpath}
    Input text                         ${client_create_SSNumberField}              ${client_SSNumber}
    Click element                      ${client_create_pg_button_save}  
    Page should contain                Client was successfully created.