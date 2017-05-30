
*** Settings ***
Resource                                  bedroom_create_page_and_keywords.robot
Resource                                  bedroom_edit_page_and_keywords.robot
*** Variables ***
${bedroom_pg_label_on_page}               List
${bedroom_pg_btn_create_newbedroom}       xpath=//*[@id="j_idt50"]/a[1]  
${bedroom_list_first_id}                  xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[1]
${bedroom_list_first_id_no}               xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[1]
${bedroom_pg_btn_edit_bedroom}            xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[8]/a[2]
${bedroom_pg_btn_delete_bedroom}          xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[8]/a[3]
${bedroom_pg_btn_view_bedroom}            xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[8]/a[1]
${txt_next}                               Next
${bedroom_pg_btn_create_if_morethan10}    xpath=//*[@id="j_idt50"]/a[2]
${bedroom_delete_sucess_msg}=             Bedroom was successfully deleted.
${bedroom_pg_view_lbl}=                   View
*** Keywords ***

Navigate_to_edit_thefirst_bedroom
    page should contain                   ${bedroom_pg_label_on_page}
    Click element                         ${bedroom_pg_btn_edit_bedroom} 
    Page should contain                   ${bedroom_edit_pg_lbl} 

Navigate_to_create_bedroom
    page should contain                   ${bedroom_pg_label_on_page}
    ${next_is_present}=  Run Keyword And Return Status    page should contain      ${txt_next}
    Run keyword if                        ${next_is_present}      click_on_create_btn_if_more_than10
    Run keyword Unless                    ${next_is_present}      click_on_create_btn_if_no_morethan10    


click_on_create_btn_if_no_more_than10
    Click element                         ${bedroom_pg_btn_create_newbedroom} 
    Page should contain                   ${bedroom_create_pg_lbl} 
    
#This test case is extenden to find the element if the page list page has more than one page then the xpath to the create button will be changed
click_on_create_btn_if_more_than10
     Click element                        ${bedroom_pg_btn_create_if_morethan10}
     Page should contain                  ${bedroom_create_pg_lbl} 
     
Delete_the_first_bedroom
    page should contain                   ${bedroom_pg_label_on_page}
    Click element                         ${bedroom_pg_btn_delete_bedroom}  
    Page should contain                   ${bedroom_delete_sucess_msg}

View_the_first_bedroom
    page should contain                   ${bedroom_pg_label_on_page}
    Click element                         ${bedroom_pg_btn_view_bedroom}  
    Page should contain                   ${bedroom_pg_view_lbl}

     
  