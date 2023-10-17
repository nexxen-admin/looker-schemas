view: v_bl_wl_pid_hour_requests {
  # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:
     SELECT   keydate ,
             placement,
             sum(requests) AS total_pid_requests
    FROM     rawdb.hourly_requests_blacklist_whitelist
    WHERE {% parameter v_blacklist_whitelist.list_type %}_{% parameter v_blacklist_whitelist.select_black_or_white %}_list IS NOT NULL AND
          {% condition v_blacklist_whitelist.keydate_date %} keydate {% endcondition %}AND
          {% condition v_blacklist_whitelist.keydate_hour %} keydate {% endcondition %}AND
          {% condition v_blacklist_whitelist.keydate_month %} keydate {% endcondition %}AND
          {% condition v_blacklist_whitelist.keydate_year %} keydate {% endcondition %}AND
          {% condition v_blacklist_whitelist.keydate_week %} keydate {% endcondition %}AND
          {% if v_blacklist_whitelist.dst_keydate_date._is_filtered %}
            keydate >= TIMESTAMPADD('day', -1, {% date_start v_blacklist_whitelist.dst_keydate_date %}) AND
            keydate < TIMESTAMPADD('day', 1, {% date_end v_blacklist_whitelist.dst_keydate_date %}) AND
          {% endif %}
          {% if v_blacklist_whitelist.dst_keydate_week._is_filtered %}
            keydate >= TIMESTAMPADD('day', -1, {% date_start v_blacklist_whitelist.dst_keydate_week %}) AND
            keydate < TIMESTAMPADD('day', 1, {% date_end v_blacklist_whitelist.dst_keydate_week %}) AND
          {% endif %}
          {% if v_blacklist_whitelist.dst_keydate_month._is_filtered %}
            keydate >= TIMESTAMPADD('day', -1, {% date_start v_blacklist_whitelist.dst_keydate_month %}) AND
            keydate < TIMESTAMPADD('day', 1, {% date_end v_blacklist_whitelist.dst_keydate_month %}) AND
          {% endif %}
          {% if v_blacklist_whitelist.dst_keydate_hour._is_filtered %}
            keydate >= TIMESTAMPADD('day', -1, {% date_start v_blacklist_whitelist.dst_keydate_hour %}) AND
            keydate < TIMESTAMPADD('day', 1, {% date_end v_blacklist_whitelist.dst_keydate_hour %}) AND
          {% endif %}
          {% if v_blacklist_whitelist.dst_keydate_year._is_filtered %}
            keydate >= TIMESTAMPADD('day', -1, {% date_start v_blacklist_whitelist.dst_keydate_year %}) AND
            keydate < TIMESTAMPADD('day', 1, {% date_end v_blacklist_whitelist.dst_keydate_year %}) AND
          {% endif %} 1=1
    GROUP BY keydate,
             placement
    ;;
  }

  dimension: primary_key {
    type:  string
    primary_key: yes
    hidden: yes
    sql:   ${keydate}||${placement_id} ;;
  }


  dimension: keydate {
    description: "Keydate"
    hidden: yes
    type: number
    sql: ${TABLE}.keydate ;;
  }

  dimension: placement_id {
    description: "Placement id"
    hidden: yes
    type: number
    sql: ${TABLE}.placement ;;
  }

  dimension: total_pid_requests {
    description: "Total Requests"
    view_label: "Report Details"
    hidden: no
    type: number
    sql: ${TABLE}.total_pid_requests ;;
  }

  measure: sum_pid_requests {
    description: "Sum Requests"
    view_label: "Report Details"
    hidden: yes
    type: sum
    sql: ${total_pid_requests} ;;
  }

  measure: placement_list_request_pct {
    description: "placement_l_request_pct"
    view_label: "Report Details"
    type: number
    value_format: "0"
    sql: 100*${v_blacklist_whitelist.total_list_requests}/NULLIF(${sum_pid_requests},0) ;;
  }


}
