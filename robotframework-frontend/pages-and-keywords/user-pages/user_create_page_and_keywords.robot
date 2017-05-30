*** Settings ***
Library            Collections
*** Variables ***
${user_create_pg_lbl}                Create New User
${user_create_lstusertype}           xpath=//*[@id="typeUser"]
${user_create_lstusertype_common}    xpath=//*[@id="typeUser"]/option[2]
${user_create_txtlogin}              xpath=//*[@id="login"]
${user_create-txtpass}               xpath=//*[@id="password"]
${user_create-txtretypepass}         xpath=//*[@id="retypingPassword"]
${user_create-lstclient}             xpath=//*[@id="clientId"] 
${user_create-lstuserstatus}         xpath=//*[@id="userStatusId"]
${user-create-lst-firstclient}       xpath=//*[@id="clientId"]/option[2]
${user_create-lstuserstatus}         xpath=//*[@id="userStatusId"]
${user-create-lst-status-active}     xpath=//*[@id="userStatusId"]/option[2]    
${user_create-btnsave}               xpath=//*[@id="j_idt51"]/a[1]

*** Keywords ***
Verify_page_contains_all_elements    
    Page should contain                ${user_create_pg_lbl}
    Page should contain element        ${user_create_txtlogin} 
    Page should contain element        ${user_create-txtpass}  
    Page should contain element        ${user_create-txtretypepass}  
    Page should contain element        ${user_create-lstclient}
    Page should contain element        ${user_create-lstuserstatus}  
    Page should contain element        ${user_create-btnsave}  
    
Create_new_common_user
    Page should contain                ${user_create_pg_lbl} 
    ${user_create_txtusername} =      Generate Random String                         7                   [LOWER]
    Click element                      ${user_create_lstusertype}  
    Click element                      ${user_create_lstusertype_common}           
    Input text                         ${user_create_txtlogin}                     ${user_create_txtusername}
    Input text                         ${user_create-txtpass}                      pass
    Input text                         ${user_create-txtretypepass}                pass
    Click element                      ${user_create-lstclient}
    Click element                      ${user-create-lst-firstclient} 
    Click element                      ${user_create-lstuserstatus} 
    Click element                      ${user-create-lst-status-active}
    Page should contain element        ${user_create-btnsave}
    Page should contain element        ${user_create-btnsave}
    Click element                      ${user_create-btnsave} 
    #page should contain                successfully

Create_new_admin_user
    Page should contain                ${user_create_pg_lbl} 
    ${user_create_txtusername} =      Generate Random String                         7                   [LOWER]
    Input text                         ${user_create_txtlogin}                     ${user_create_txtusername}
    Input text                         ${user_create-txtpass}                      pass
    Input text                         ${user_create-txtretypepass}                pass
    Click element                      ${user_create-lstclient}
    Click element                     ${user-create-lst-firstclient}
    Click element                      ${user_create-lstuserstatus} 
    Click element                      ${user-create-lst-status-active}
    Page should contain element        ${user_create-btnsave}
    Page should contain element        ${user_create-btnsave}
    Click element                      ${user_create-btnsave}
    #page should contain                successfully 
    