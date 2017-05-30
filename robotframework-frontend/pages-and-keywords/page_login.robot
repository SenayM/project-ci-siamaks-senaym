*** Settings***
Resource                                        ../credentials/login_variables.robot
Resource                                       page_dashboard.robot
***Variable ***

#login Form
${login_pg_user_textfield}                     id=login  
${login_pg_password_textfield}                 id=senha 
${login_pg_btn_login}                          id=loginBtn
${login_pg_label_dashboard}                    Hotel Accomodation - login page 

***Keywords***
Perform_login_as_normal_user
    
    Input Text                                 ${login_pg_user_textfield}                                              ${normal_username} 
    Input Text                                 ${login_pg_password_textfield}                                          ${normal_password}
    Click Element                              ${login_pg_btn_login} 
    Wait until Page Contains                   ${dashboard_pg_label_dashboard}

 Perform_login_as_admin_user    
    Input Text                                 ${login_pg_user_textfield}                                              ${admin_username} 
    Input Text                                 ${login_pg_password_textfield}                                          ${admin_password}
    Click Element                              ${login_pg_btn_login} 
    Wait until Page Contains                   ${dashboard_pg_label_on_page}