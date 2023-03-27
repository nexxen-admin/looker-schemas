view: mssql_oltp_an_hist_campaign_target {
  label: "Campaign Tergeting KPI"

  derived_table: {
    sql:

    {% if count_configured_geographic._in_query
      or count_configured_daypart._in_query
      or count_configured_contextual._in_query
      or count_configured_technology._in_query
      or count_configured_custom_segment._in_query
      or count_configured_tv_viewing_behavioral._in_query
      or count_configured_behavioral._in_query
    %}
    select
      case
        when t.attribute_id = 6 then 'daypart_conf'
        when t.attribute_id in (5, 30) then 'geographic_conf'
        when t.attribute_id = 200 then 'contextual_conf'
        when t.attribute_id in (8, 9, 12, 112, 113) then 'technology_conf'
        when t.attribute_id = 20 then
          case
            when ra.retargeting_attribute_type_id = 4 then 'custom_segment_conf'
            when ra.retargeting_attribute_type_id = 1 then
              case when ra.behavioral_category_id in (320, 322, 323) then 'tv_viewing_conf'
              else 'behavioral_conf'
              end
          end
      end as column_name,
      null as tran_time,
      t.campaign_id
    from AN_MAIN..campaign_target t (nolock)
      left join retargeting_attribute ra (nolock)
        on t.attribute_value_id = ra.retargeting_attribute_id
    where t.attribute_id in (
      {% if count_configured_daypart._in_query %}
      6,
      {% endif %}
      {% if count_configured_geographic._in_query %}
      5, 30,
      {% endif %}
      {% if count_configured_contextual._in_query %}
      200,
      {% endif %}
      {% if count_configured_technology._in_query %}
      8, 9, 12, 112, 113,
      {% endif %}
      {% if count_configured_custom_segment._in_query
        or count_configured_tv_viewing_behavioral._in_query
        or count_configured_behavioral._in_query
      %}
      20,
      {% endif %}
      null
    )
      and {% condition campaign_id %} t.campaign_id {% endcondition %}
    group by
      t.campaign_id,
      t.attribute_id,
      ra.retargeting_attribute_type_id,
      ra.behavioral_category_id

    union all

    {% endif %}

    {% if count_modified_geographic._in_query
      or count_modified_diff_geographic._in_query
      or count_modified_daypart._in_query
      or count_modified_diff_daypart._in_query
      or count_modified_contextual._in_query
      or count_modified_diff_contextual._in_query
      or count_modified_technology._in_query
      or count_modified_diff_technology._in_query
      or count_modified_custom_segment._in_query
      or count_modified_tv_viewing_behavioral._in_query
      or count_modified_behavioral._in_query
      or count_modified_diff_behavioral._in_query
    %}

    select
      case
        when table_ct.attribute_id = 6 then 'daypart'
        when table_ct.attribute_id in (5, 30) then 'geographic'
        when table_ct.attribute_id = 200 then 'contextual'
        when table_ct.attribute_id in (8, 9, 12, 112, 113) then 'technology'
        when table_ct.attribute_id = 20 then
          case
            when ra.retargeting_attribute_type_id = 4 then 'custom_segment'
            when ra.retargeting_attribute_type_id = 1 then
              case when ra.behavioral_category_id in (320, 322, 323) then 'tv_viewing'
              else 'behavioral'
              end
          end
      end as column_name,
      table_ct.tran_time,
      table_ct.campaign_id
    from AN_HIST..dbo_campaign_target_CT table_ct (nolock)
      left join retargeting_attribute ra (nolock)
        on table_ct.attribute_value_id = ra.retargeting_attribute_id
    where table_ct.attribute_id in (
    {% if count_modified_daypart._in_query
      or count_modified_diff_daypart._in_query %}
    6,
    {% endif %}
    {% if count_modified_geographic._in_query
      or count_modified_diff_geographic._in_query %}
    5, 30,
    {% endif %}
    {% if count_modified_contextual._in_query
      or count_modified_diff_contextual._in_query %}
    200,
    {% endif %}
    {% if count_modified_technology._in_query
      or count_modified_diff_technology._in_query %}
    8, 9, 12, 112, 113,
    {% endif %}
    {% if count_modified_custom_segment._in_query
      or count_modified_tv_viewing_behavioral._in_query
      or count_modified_behavioral._in_query
      or count_modified_diff_behavioral._in_query
    %}
    20,
    {% endif %}
    null
    )
      and table_ct.__$operation != 3

      and {% condition tran_time_raw %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_time %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_date %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_week %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_month %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_quarter %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_year %} table_ct.tran_time {% endcondition %}

      and {% condition campaign_id %} table_ct.campaign_id {% endcondition %}

    group by
      table_ct.campaign_id,
      table_ct.attribute_id,
      ra.retargeting_attribute_type_id,
      ra.behavioral_category_id,
      table_ct.tran_time,
      table_ct.__$start_lsn

    union all

    {% endif %}

    {% if count_configured_demographic._in_query %}
    select
      'demographic_conf' as column_name,
      null as tran_time,
      t.campaign_id
    from AN_MAIN..campaign_demo t (nolock)
    where t.active = 0
      and {% condition campaign_id %} t.campaign_id {% endcondition %}
    group by
      t.campaign_id

    union all

    {% endif %}

    {% if count_configured_targets._in_query %}
    select
      'targets_conf' as column_name,
      null as tran_time,
      t.entity_id as campaign_id
    from AN_MAIN..expression_entity t (nolock)
    where t.active = 1
      and {% condition campaign_id %} t.entity_id {% endcondition %}
    group by
      t.entity_id

    union all

    {% endif %}

    {% if count_configured_frequency_cap._in_query %}

    select
      'freq_cap_conf' as column_name,
      null as tran_time,
      t.campaign_id
    from AN_MAIN..campaign t (nolock)
    where t.freq_cap != 0
      and {% condition campaign_id %} t.campaign_id {% endcondition %}

    union all

    {% endif %}

    {% if count_modified_frequency_cap._in_query
      or count_modified_diff_frequency_cap._in_query %}

    select
      'freq_cap' as column_name,
      table_ct.tran_time,
      table_ct.campaign_id
    from AN_HIST..dbo_campaign_CT table_ct (nolock)
      join cdc.captured_columns cc (nolock)
        on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
      join cdc.change_tables ct (nolock)
        on cc.object_id = ct.object_id
    where ct.capture_instance = 'dbo_campaign'
      and cc.column_name in (
        'freq_cap',
        'freq_cap_hours',
        'freq_cap_unit'
      )
      and table_ct.__$operation = 4

      and {% condition tran_time_raw %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_time %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_date %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_week %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_month %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_quarter %} table_ct.tran_time {% endcondition %}
      and {% condition tran_time_year %} table_ct.tran_time {% endcondition %}

      and {% condition campaign_id %} table_ct.campaign_id {% endcondition %}

    group by
      table_ct.campaign_id,
      table_ct.__$start_lsn,
      table_ct.tran_time,
      table_ct.__$operation

    union all

    {% endif %}


    {% if count_configured_manage_demographics._in_query
      or count_modified_manage_demographics._in_query
      or count_configured_manage_behavioral._in_query
      or count_modified_manage_behavioral._in_query
      or count_modified_diff_behavioral._in_query
      or count_configured_manage_geographic._in_query
      or count_modified_manage_geographic._in_query
      or count_modified_diff_geographic._in_query
      or count_configured_manage_daypart._in_query
      or count_modified_manage_daypart._in_query
      or count_modified_diff_daypart._in_query
      or count_configured_manage_technology._in_query
      or count_modified_manage_technology._in_query
      or count_modified_diff_technology._in_query
      or count_configured_manage_contextual._in_query
      or count_modified_manage_contextual._in_query
      or count_modified_diff_contextual._in_query
      or count_configured_manage_frequency_cap._in_query
      or count_modified_manage_frequency_cap._in_query
      or count_modified_diff_frequency_cap._in_query
    %}

    select
      case
        when comment_type_id in (14, 15) then 'manage_demographics'
        when comment_type_id in (8, 9) then 'manage_behavioral'
        when comment_type_id in (18, 19, 20, 21) then 'manage_geographic'
        when comment_type_id in (43, 44) then 'manage_daypart'
        when comment_type_id in (45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56) then 'manage_technology'
        when comment_type_id in (37, 38) then 'manage_contextual'
        when comment_type_id in (11, 12, 13) then 'manage_frequency_cap'
      end as column_name,
      t.posted_date as tran_time,
      t.campaign_id
    from AN_MAIN..campaign_comment t (nolock)
    where t.comment_type_id in (
      {% if count_configured_manage_demographics._in_query
        or count_modified_manage_demographics._in_query
      %}
      14, 15,
      {% endif %}
      {% if count_configured_manage_behavioral._in_query
        or count_modified_manage_behavioral._in_query
        or count_modified_diff_behavioral._in_query
      %}
      8, 9,
      {% endif %}
      {% if count_configured_manage_geographic._in_query
        or count_modified_manage_geographic._in_query
        or count_modified_diff_geographic._in_query
      %}
      18, 19, 20, 21,
      {% endif %}
      {% if count_configured_manage_daypart._in_query
        or count_modified_manage_daypart._in_query
        or count_modified_diff_daypart._in_query
      %}
      43, 44,
      {% endif %}
      {% if count_configured_manage_technology._in_query
        or count_modified_manage_technology._in_query
        or count_modified_diff_technology._in_query
      %}
      45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56,
      {% endif %}
      {% if count_configured_manage_contextual._in_query
        or count_modified_manage_contextual._in_query
        or count_modified_diff_contextual._in_query
      %}
      37, 38,
      {% endif %}
      {% if count_configured_manage_frequency_cap._in_query
        or count_modified_manage_frequency_cap._in_query
        or count_modified_diff_frequency_cap._in_query
      %}
      11, 12, 13,
      {% endif %}
      null
    )
      and {% condition tran_time_raw %} t.posted_date {% endcondition %}
      and {% condition tran_time_time %} t.posted_date {% endcondition %}
      and {% condition tran_time_date %} t.posted_date {% endcondition %}
      and {% condition tran_time_week %} t.posted_date {% endcondition %}
      and {% condition tran_time_month %} t.posted_date {% endcondition %}
      and {% condition tran_time_quarter %} t.posted_date {% endcondition %}
      and {% condition tran_time_year %} t.posted_date {% endcondition %}

      and {% condition campaign_id %} t.campaign_id {% endcondition %}

    {% else %}

    select top 0
      null as column_name,
      null as tran_time,
      null as campaign_id

    {% endif %}
  ;;
  }

  dimension: column_name {
    type: string
    hidden: yes
    sql: ${TABLE}.column_name ;;
  }

  dimension_group: tran_time {
    type: time
    label: "Modified"
    view_label: "Count Modified (Date to Filter)"
    description: "Time of the transaction for filtering Count Modified measures. Filtering by this field will disable Count Configured measures!"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.tran_time ;;
  }

  dimension: campaign_id {
    view_label: "Campaign"
    type: number
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  measure: count_configured_geographic {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'geographic_conf' then 1 end ;;
  }

  measure: count_modified_geographic {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'geographic' then 1 end ;;
  }

  measure: count_configured_daypart {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'daypart_conf' then 1 end ;;
  }

  measure: count_modified_daypart {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'daypart' then 1 end ;;
  }

  measure: count_configured_contextual {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'contextual_conf' then 1 end ;;
  }

  measure: count_modified_contextual {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'contextual' then 1 end ;;
  }

  measure: count_configured_technology {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'technology_conf' then 1 end ;;
  }

  measure: count_modified_technology {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'technology' then 1 end ;;
  }

  measure: count_configured_custom_segment {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'custom_segment_conf' then 1 end ;;
  }

  measure: count_modified_custom_segment {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'custom_segment' then 1 end ;;
  }

  measure: count_configured_tv_viewing_behavioral {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'tv_viewing_conf' then 1 end ;;
  }

  measure: count_modified_tv_viewing_behavioral {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'tv_viewing' then 1 end ;;
  }

  measure: count_configured_behavioral {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'behavioral_conf' then 1 end ;;
  }

  measure: count_modified_behavioral {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'behavioral' then 1 end ;;
  }

  measure: count_configured_demographic {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'demographic_conf' then 1 end ;;
  }

  measure: count_configured_targets {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'targets_conf' then 1 end ;;
  }

  measure: count_configured_frequency_cap {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'freq_cap_conf' then 1 end ;;
  }

  measure: count_modified_frequency_cap {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'freq_cap' then 1 end ;;
  }

  measure: count_configured_manage_demographics {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_demographics' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_demographics {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_demographics' then 1 end ;;
  }

  measure: count_configured_manage_behavioral {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_behavioral' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_behavioral {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_behavioral' then 1 end ;;
  }

  measure: count_modified_diff_behavioral {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_behavioral} - ${count_modified_manage_behavioral} ;;
  }

  measure: count_configured_manage_geographic {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_geographic' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_geographic {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_geographic' then 1 end ;;
  }

  measure: count_modified_diff_geographic {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_geographic} - ${count_modified_manage_geographic} ;;
  }

  measure: count_configured_manage_daypart {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_daypart' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_daypart {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_daypart' then 1 end ;;
  }

  measure: count_modified_diff_daypart {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_daypart} - ${count_modified_manage_daypart} ;;
  }

  measure: count_configured_manage_technology {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_technology' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_technology {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_technology' then 1 end ;;
  }

  measure: count_modified_diff_technology {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_technology} - ${count_modified_manage_technology} ;;
  }

  measure: count_configured_manage_contextual {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_contextual' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_contextual {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_contextual' then 1 end ;;
  }

  measure: count_modified_diff_contextual {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_contextual} - ${count_modified_manage_contextual} ;;
  }

  measure: count_configured_manage_frequency_cap {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_frequency_cap' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_frequency_cap {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_frequency_cap' then 1 end ;;
  }

  measure: count_modified_diff_frequency_cap {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_frequency_cap} - ${count_modified_manage_frequency_cap} ;;
  }

  dimension: dummy_for_transposing {
    view_label: "Custom Dimensions"
    case: {
      when: {
        label: "Count Configured Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Contextual"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Custom Segment"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Daypart"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Demographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Frequency Cap"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Geographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Targets"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Technology"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Tv Viewing Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Contextual"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Daypart"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Demographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Frequency Cap"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Geographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Technology"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Contextual"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Custom Segment"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Daypart"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Frequency Cap"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Geographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Technology"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Tv Viewing Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Contextual"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Daypart"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Demographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Frequency Cap"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Geographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Technology"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Behavioral"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Contextual"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Daypart"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Frequency Cap"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Geographic"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Technology"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
    }
  }
}
