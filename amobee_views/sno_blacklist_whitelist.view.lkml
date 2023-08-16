view: sno_blacklist_whitelist {
  derived_table: {
    sql: SELECT p.placement_id,
           p.placement_name,
           p.device_type,
           p.partner_name as publisher,
           p.platform_client, t.*
FROM
           (
                            SELECT         l.placement::integer as placement,
                                             l.keydate as keydate,
                                             l.value as id,
                                             l.requests as l_requests,
                                             l.{% parameter list_type %}_{% parameter select_black_or_white %}_list as list,
                                             l."col 1" as list_size,
                                             l.pdata1
                            FROM           (
                                                      SELECT EXPLODE(
                                                      {% parameter list_type %}_{% parameter select_black_or_white %}_list,
                                                      IFNULL(array_length({% parameter list_type %}_{% parameter select_black_or_white %}_list),0),
                                                             r.*) OVER(PARTITION BEST)
                                                      FROM   rawdb.hourly_requests_blacklist_whitelist AS r

                                                      WHERE
                                                      {% parameter list_type %}_{% parameter select_black_or_white %}_list IS NOT NULL AND
                                                       {% condition keydate_date %} r.keydate {% endcondition %}AND
                                                       {% condition keydate_hour %} r.keydate {% endcondition %}AND
                                                       {% condition keydate_month %} r.keydate {% endcondition %}AND
                                                       {% condition keydate_year %} r.keydate {% endcondition %}AND
                                                       {% condition keydate_week %} r.keydate {% endcondition %}
                                                      AND
                                                         {% if dst_keydate_date._is_filtered %}
                                                              r.keydate >= TIMESTAMPADD('day', -1, {% date_start dst_keydate_date %}) AND
                                                              r.keydate < TIMESTAMPADD('day', 1, {% date_end dst_keydate_date %}) AND
                                                            {% endif %}
                                                            {% if dst_keydate_week._is_filtered %}
                                                              r.keydate >= TIMESTAMPADD('day', -1, {% date_start dst_keydate_week %}) AND
                                                              r.keydate < TIMESTAMPADD('day', 1, {% date_end dst_keydate_week %}) AND
                                                            {% endif %}
                                                            {% if dst_keydate_month._is_filtered %}
                                                              r.keydate >= TIMESTAMPADD('day', -1, {% date_start dst_keydate_month %}) AND
                                                              r.keydate < TIMESTAMPADD('day', 1, {% date_end dst_keydate_month %}) AND
                                                            {% endif %}
                                                            {% if dst_keydate_hour._is_filtered %}
                                                              r.keydate >= TIMESTAMPADD('day', -1, {% date_start dst_keydate_hour %}) AND
                                                              r.keydate < TIMESTAMPADD('day', 1, {% date_end dst_keydate_hour %}) AND
                                                            {% endif %}
                                                            {% if dst_keydate_year._is_filtered %}
                                                              r.keydate >= TIMESTAMPADD('day', -1, {% date_start dst_keydate_year %}) AND
                                                              r.keydate < TIMESTAMPADD('day', 1, {% date_end dst_keydate_year %}) AND
                                                            {% endif %}
                                                            1=1
                                                ) l


                              )
                              AS t
             join dim.placement_details_base_view p
ON         p.placement_id = t.placement
      ;;
  }

  parameter: list_type {
    label: "Report type"
    view_label: "Report Details"
    description: "Brand, Industry Segment or Ad Category"
    type: unquoted
    allowed_value: {
      label: "Brand"
      value: "brand"
    }
    allowed_value: {
      label: "Industry Segment"
      value: "industry_segment"
    }
    allowed_value: {
      label: "Publisher Ad Category"
      value: "publisher_ad_category"
    }
  }

  parameter: select_black_or_white {
    view_label: "Report Details"
    description: "Select Blacklist or Whitelist"
    type: unquoted
    allowed_value: {
      label: "Blacklist"
      value: "black"
    }
    allowed_value: {
      label: "Whitelist"
      value: "white"
    }
  }

  dimension: l_requests {
    view_label: "Report Details"
    description: "List requests"
    type: number
    hidden: yes
    sql: ${TABLE}.l_requests ;;
  }

  dimension: id {
    description: "blacklisted_id or whitelisted_id"
    view_label: "Report Details"
    type: string
    sql: ${TABLE}.id ;;
    suggestable: no
  }


 dimension:list {
    description: "list"
    view_label: "Report Details"
    type: string
    sql: ${TABLE}.list ;;
  }


  dimension: list_size {
    description: "list_size"
    view_label: "Report Details"
    type: number
    sql: ${TABLE}.list_size ;;
  }

  dimension: placement_name {
    description: "Placement name"
    view_label: "Report Details"
    type: string
    sql: ${TABLE}.placement_name ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_name
  }

  dimension: placement_id {
    description: "Placement id"
    view_label: "Report Details"
    type: number
    value_format: "0"
    sql: ${TABLE}.placement ;;
  }

  dimension: device_type {
    description: "Device Type"
    view_label: "Report Details"
    type: string
    sql: ${TABLE}.device_type ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.device_type
  }

  dimension_group: keydate {
    description: "Keydate"
    label: "UTC"
    view_label: "Report Details"
    type: time
    timeframes: [raw, hour, date, week, month, year]
    sql: ${TABLE}.keydate ;;
  }

  dimension_group: dst_keydate {
    description: "Keydate on local time accounting DST"
    label: "[DST] Local"
    view_label: "Report Details"
    type: time
    timeframes: [raw, hour, date, week, month, year]
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name}, ${TABLE}.keydate)
      else ${TABLE}.keydate end ;;
  }

  dimension: publisher {
    description: "Partner name or Publisher"
    view_label: "Report Details"
    type: string
    sql: ${TABLE}.publisher ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.partner_name
  }

  dimension: p_data {
    description: "P Data"
    view_label: "Report Details"
    type: string
    sql: ${TABLE}.pdata1 ;;
  }

  measure: total_list_requests {
    description: "Total Blacklist or Whitelist Requests"
    view_label: "Report Details"
    type: sum
    sql: ${l_requests} ;;
  }

}
