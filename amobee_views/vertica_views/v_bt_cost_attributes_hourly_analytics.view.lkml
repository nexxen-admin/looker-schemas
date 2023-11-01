view: v_bt_cost_attributes_hourly_analytics {

  derived_table: {
    sql:
    select
          ha.PK_ID,
          ha.PROCESSINGID,
          bt_attribute_id,
          demand_bt_markup,
          supply_bt_cost,
          supply_bt_cost_currency,
          bt_provider_id,
          demand_provider_cost,
          'HOURLY_ANALYTICS' as SOURCE
    FROM RAWDB.HOURLY_ANALYTICS ha
    JOIN RAWDB.HOURLY_ANALYTICS_BT_COST_ATTRIBUTES bt
    ON ha.BT_ID = bt.BT_ID and ha.PROCESSINGID = bt.PROCESSINGID
    WHERE
      {% if v_hourly_analytics.demand_date_date._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_hour._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_month._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_time._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_year._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.raw_demand_date._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}


      {% if v_hourly_analytics.supply_date_date._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_hour._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_month._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_time._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_year._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.raw_supply_date._is_filtered %}
            ha.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
            ha.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}

    1=1
    AND  ("datediff"('DAY'::varchar(3), ha.GMT_DATE, (now())::date)<= 7)

    UNION ALL

    select
          da.PK_ID,
          da.PROCESSINGID,
          bt_attribute_id,
          demand_bt_markup,
          supply_bt_cost,
          supply_bt_cost_currency,
          bt_provider_id,
          demand_provider_cost,
          'DAILY_ANALYTICS' as SOURCE
    FROM RAWDB.DAILY_ANALYTICS da
    JOIN RAWDB.DAILY_ANALYTICS_BT_COST_ATTRIBUTES bt
    ON da.BT_ID = bt.BT_ID and da.PROCESSINGID = bt.PROCESSINGID
    WHERE
       {% if v_hourly_analytics.demand_date_date._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_hour._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_hour %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_month._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_month %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_time._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_time %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.demand_date_year._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.demand_date_year %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.raw_demand_date._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_demand_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}


        {% if v_hourly_analytics.supply_date_date._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_hour._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_hour %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_month._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_month %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_time._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_time %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.supply_date_year._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.supply_date_year %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      {% if v_hourly_analytics.raw_supply_date._is_filtered %}
            da.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
            da.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID >= TO_CHAR(TIMESTAMPADD('day', -1, {% date_start v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
            bt.PROCESSINGID < TO_CHAR(TIMESTAMPADD('day', 1, {% date_end v_hourly_analytics.raw_supply_date %}), 'YYYYMMDDHH')::Integer AND
      {% endif %}
      1=1
    AND  ("datediff"('DAY'::varchar(3), da.GMT_DATE, (now())::date)  > 7) ;;
    }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: {{_explore._name}}.pk_id || ${bt_cost_attribute}|| ${bt_provider} ;;
  }

  dimension: bt_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BT_ID;;
  }

  dimension: source {
    type: string
    hidden: yes
    sql: ${TABLE}.SOURCE ;;
  }

  dimension: pk_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PK_ID ;;
  }

  dimension: bt_cost_attribute {
    type: number
    label: "BT Cost Attribute"
    view_label: "Supplemental Facets"
    description: "The attribute used in determining the BT Costs."
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.bt_attribute_id else bt_cost_attribute end ;;
    value_format_name: id
  }

  dimension: bt_cost_markup {
    type: number
    hidden: yes
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.demand_bt_markup / 100000 else bt_cost_markup end ;;
  }

  measure: sum_bt_cost_markup {
    type: sum
    label: "BT Cost Markup"
    description: "The total markup cost for Behavioral Targeting"
    value_format_name: decimal_2
    sql: ${bt_cost_markup} ;;
  }

  dimension: bt_data_cost {
    type: number
    hidden: yes
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.supply_bt_cost / 100000 else bt_data_cost end ;;
  }

  measure: sum_bt_data_cost {
    type: sum
    label: "BT Data Cost"
    description: "The total cost for Behavioral Targeting data"
    value_format_name: decimal_2
    sql: ${bt_data_cost} ;;
  }

  dimension: bt_data_cost_currency {
    type: string
    label: "BT Data Cost Currency"
    description: "The currency of the BT data cost"
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.supply_bt_cost_currency else bt_data_cost_currency end ;;
  }

  dimension: bt_provider {
    type: string
    view_label: "Supplemental Facets"
    hidden: yes
    description: "The Data Provider used in creating the BT data"
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.bt_provider_id else {% if _explore._name == 'v_raw_impression' %} bt_providerid {% elsif  _explore._name == 'v_hourly_analytics' or _explore._name == 'v_hourly_analytics_wopr_only' %} bt_provider {% endif %} end ;;
    value_format_name: id
  }

  dimension: demand_bt_provider_cost {
    type: number
    hidden: yes
    sql: case when {{_explore._name}}.demand_date >= '2022-03-09' then ${TABLE}.demand_provider_cost / 100000 else demand_bt_provider_cost end ;;
  }

  measure: sum_demand_bt_provider_cost {
    type: sum
    label: "BT Data Costs - Demand Currency"
    description: "The total Behavioral Targeting costs converted from the native currency to the demand currency."
    value_format_name: decimal_2
    sql: ${demand_bt_provider_cost};;
  }

}
