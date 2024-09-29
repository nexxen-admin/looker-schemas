view: advertiser_email_druid {

  derived_table: {
    sql: SELECT
        advertiser_id,
        'roni-test@nexxen.com' as email,
        'Test' as First_Name,
        'User' as Last_Name
        from druid.dsp_media_and_bids
        where advertiser_id='1608944983'
      ;;
  }
  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.First_Name ;;
    hidden: yes
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.Last_Name ;;
    hidden: yes
  }
 }
