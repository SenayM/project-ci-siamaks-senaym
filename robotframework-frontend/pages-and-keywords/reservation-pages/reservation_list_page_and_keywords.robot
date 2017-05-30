*** Variables ***
${resrvation_pg_label_on_page}                      List
${reservation_pg_delete_msg}                        xpath=//*[@id="messagePanel"]/table/tbody/tr/td
${reservation_list_pg_button_delete}                xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[8]/a[3]
${reservation_list_pg_delete_msg_text}              HotelReservation was successfully deleted.


*** Keywords ***
delete_first_reservation_and_verify
    page should contain element                     ${reservation_list_pg_button_delete}
    click element                                   ${reservation_list_pg_button_delete}
    Element text should be                          ${reservation_pg_delete_msg}                     ${reservation_list_pg_delete_msg_text}