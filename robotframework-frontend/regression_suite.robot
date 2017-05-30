***Settings***
Library                        Selenium2Library
Library                        OperatingSystem
Library                        String

Resource                        ./credentials/login_variables.robot
Resource                        ./pages-and-keywords/test_setup_and_teardown.robot
Resource                        ./pages-and-keywords/page_login.robot
Resource                        ./pages-and-keywords/page_dashboard.robot
Resource                        ./pages-and-keywords/user-pages/user_list_page_and_keywords.robot
Resource                        ./pages-and-keywords/user-pages/user_create_page_and_keywords.robot
Resource                        ./pages-and-keywords/bedroom-pages/bedroom_list_page_and_keywords.robot
Resource                        ./pages-and-keywords/bedroom-pages/bedroom_create_page_and_keywords.robot
Resource                        ./pages-and-keywords/client-pages/client_create_page_and_keywords.robot
Resource                        ./pages-and-keywords/client-pages/client_list_page_and_keywords.robot

Test setup                     Setup
Test teardown                  Teardown

***Test cases***

Test Case 1 login and logout
    Perform_login_as_admin_user
    perform_logout
    
Test Case 2 create bedroom
    Perform_login_as_admin_user
    navigate_to_bedroom_page_link_left
    Navigate_to_create_bedroom
    Create_new_vacant_classicbedking_bedroom
    perform_logout
    
Test Case 3 View Bedroom
    Perform_login_as_admin_user
    navigate_to_bedroom_page_link_left
    View_the_first_bedroom
    perform_logout
    
Test Case 4 Delete bedroom
    Perform_login_as_admin_user
    navigate_to_bedroom_page_link_left
    Delete_the_first_bedroom
    perform_logout

Test Case 5 view_a_bill
    perform_login_as_admin_user
    navigate_to_bill_page_link_left
    view_first_bill_and_verify
    perform_logout
 
Test Case 6 delete_a_reservation
    perform_login_as_admin_user
    navigate_to_reservation_page_link_left
    delete_first_reservation_and_verify
    perform_logout

Test Case 7 all_buttons_on_client_view_page
    perform_login_as_admin_user
    navigate_to_client_page_link_left
    navigate_to_client_view_pg    
    verify_client_view_page_contains_all_elements
    click_showall_btn_on_client_view_pg_and_verify
    navigate_to_client_view_pg
    click_create_btn_on_client_view_pg_and_verify
    navigate_to_client_view_pg
    click_index_btn_on_client_view_pg_and_verify
    perform_logout

Test Case 8 create_client
    perform_login_as_admin_user
    navigate_to_client_page_link_left
    navigate_to_create_client_form
    create_new_client_and_verify
    perform_logout

Test Case 9 view_a_client
    perform_login_as_admin_user
    navigate_to_client_page_link_left
    view_client_and_verify
    perform_logout

Test Case 10 delete_a_client
    perform_login_as_admin_user
    navigate_to_client_page_link_left
    delete_client_and_verify
    perform_logout