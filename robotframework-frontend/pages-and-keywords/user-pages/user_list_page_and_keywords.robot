*** Settings ***
Resource                                     user_create_page_and_keywords.robot
*** Variables ***
${user_pg_label_on_page}                      List
${user_pg_btn_create_new_user}                xpath=//*[@id="j_idt50"]/a[1]

*** Keywords ***
Navigate_to_create_user_form
    page should contain                   ${user_pg_label_on_page}
    Click element                         ${user_pg_btn_create_new_user} 
    Page should contain                   ${user_create_pg_lbl} 