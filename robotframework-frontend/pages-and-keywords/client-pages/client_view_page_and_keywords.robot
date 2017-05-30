*** Settings ***
Resource                             client_list_page_and_keywords.robot
Resource                             client_edit_page_and_keywords.robot
Resource                             client_create_page_and_keywords.robot
Resource                             ../page_dashboard.robot


*** Variables ***
${client_lable_on_pg_view}           View
${client_view_pg_button_delete}      xpath=//*[@id="j_idt51"]/a[1]
${client_view_pg_button_edit}        xpath=//*[@id="j_idt51"]/a[2]
${client_view_pg_button_create}      xpath=//*[@id="j_idt51"]/a[3]
${client_view_pg_button_showall}     xpath=//*[@id="j_idt51"]/a[4]
${client_view_pg_button_index}       xpath=//*[@id="j_idt51"]/a[5]
${client_view_pg_msg_delete}         Client was successfully deleted.
${client_view_pg_msg_edit}           Client was successfully updated.
${client_view_pg_field_id}           xpath=//*[@id="j_idt51"]/table/tbody/tr[1]/td[2]/span


*** Keywords ***
verify_client_view_page_contains_all_elements    
    Page should contain                ${client_lable_on_pg_view}
    Page should contain element        ${client_view_pg_button_delete} 
    Page should contain element        ${client_view_pg_button_edit}  
    Page should contain element        ${client_view_pg_button_create}  
    Page should contain element        ${client_view_pg_button_showall}
    Page should contain element        ${client_view_pg_button_index}

click_delete_btn_on_client_view_pg_and_verify    
    Click element                      ${client_view_pg_button_delete}
    Wait until page contains           ${client_view_pg_msg_delete}
    Page should contain                ${client_view_pg_msg_delete}
    Click element                      ${client_view_pg_button_showall}

click_create_btn_on_client_view_pg_and_verify    
    Click element                      ${client_view_pg_button_create}
    Wait until page contains           ${client_pg_label_on_page_create}
    Page should contain                ${client_pg_label_on_page_create}
    Click element                      ${client_create_pg_button_showall}

click_showall_btn_on_client_view_pg_and_verify    
    Click element                      ${client_view_pg_button_showall}
    Wait until page contains           ${client_pg_label_on_page}
    Page should contain                ${client_pg_label_on_page}

click_index_btn_on_client_view_pg_and_verify    
    Click element                      ${client_view_pg_button_index}
    Wait until page contains           ${dashboard_pg_label_dashboard}
    Page should contain                ${dashboard_pg_label_dashboard}