*** Settings ***
Resource                                  client_view_page_and_keywords.robot
Resource                                  client_edit_page_and_keywords.robot
Resource                                  client_create_page_and_keywords.robot

*** Variables ***
${client_pg_label_on_page}                List
${client_list_pg_delete_msg_text}         Client was successfully deleted.
${client_pg_delete_msg}                   xpath=//*[@id="messagePanel"]/table/tbody/tr/td
${client_pg_btn_edit_client}              xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[7]/a[2]
${client_list_pg_button_view}             xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[7]/a[1]
${client_list_pg_button_viewCreated}      xpath=//*[@id="j_idt50"]/table/tbody/tr[6]/td[7]/a[1]
${client_list_pg_button_create}           xpath=//*[@id="j_idt50"]/a[1]
${client_list_pg_button_delete}           xpath=//*[@id="j_idt50"]/table/tbody/tr[6]/td[7]/a[3]
${client_list_pg_field_id}                xpath=//*[@id="j_idt50"]/table/tbody/tr[6]/td[1]

*** Keywords ***
Navigate_to_edit_client
    Page should contain                   ${client_pg_label_on_page}     
    Click Element                         ${client_pg_btn_edit_client}   
    Page should contain                   ${client_edit_pg_lbl}

navigate_to_client_view_pg
    Click element                         ${client_list_pg_button_view}
    Wait until page contains              ${client_lable_on_pg_view}

view_client_and_verify
    Page should contain element           ${client_list_pg_button_view}
    ${client_list_pg_field_id_text}=      Get Text                                   ${client_list_pg_field_id}
    Click element                         ${client_list_pg_button_viewCreated}
    Wait until page contains              ${client_lable_on_pg_view}
    Element text should be                ${client_view_pg_field_id}                 ${client_list_pg_field_id_text}

delete_client_and_verify
    page should contain element           ${client_list_pg_button_delete}
    click element                         ${client_list_pg_button_delete}
    Element text should be                ${client_pg_delete_msg}                    ${client_list_pg_delete_msg_text}

navigate_to_create_client_form
    page should contain                   ${client_pg_label_on_page}
    Click element                         ${client_list_pg_button_create} 
    Page should contain                   ${client_pg_label_on_page_create}