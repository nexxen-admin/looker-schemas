view: mssql_oltp_an_hist_campaign {
  label: "Campaign Settings KPI"

  derived_table: {
    sql:

      {% if count_configured_campaign_name._in_query
        or count_configured_smoothness_upper._in_query
        or count_configured_smoothness_lower._in_query
        or count_configured_overage_threshold._in_query
        or count_configured_pricing_type._in_query
        or count_configured_campaign_format._in_query
        or count_configured_spreader._in_query
        or count_configured_audit_factor._in_query
        or count_configured_3rd_party_tracking._in_query
      %}

      select
        a.column_name,
        -1 as operation_type,
        null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign t (nolock)
        join (
          {% if count_configured_campaign_name._in_query %}
          select 'campaign_name_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_pricing_type._in_query %}
          select 'cpu_type_id_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_campaign_format._in_query %}
          select 'format_device_type_id_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_spreader._in_query %}
          select 'spread_fraction_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_audit_factor._in_query %}
          select 'audit_factor_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_3rd_party_tracking._in_query %}
          select 'audit_vendor_id_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_smoothness_upper._in_query %}
          select 'smoothness_upper_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_smoothness_lower._in_query %}
          select 'smoothness_lower_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_overage_threshold._in_query %}
          select 'overage_threshold_conf' as column_name
          union all
          {% endif %}
          select 'placeholder' as column_name
        ) a
          on
            1 = 0
            {% if count_configured_campaign_name._in_query %}
            or (t.campaign_name is not null and a.column_name = 'campaign_name_conf')
            {% endif %}
            {% if count_configured_pricing_type._in_query %}
            or (t.cpu_type_id is not null and a.column_name = 'cpu_type_id_conf')
            {% endif %}
            {% if count_configured_campaign_format._in_query %}
            or ((t.format_type_id is not null or t.device_type_id is not null) and a.column_name = 'format_device_type_id_conf')
            {% endif %}
            {% if count_configured_spreader._in_query %}
            or (t.spread_fraction is not null and a.column_name = 'spread_fraction_conf')
            {% endif %}
            {% if count_configured_audit_factor._in_query %}
            or (t.audit_factor not in (0, 1) and a.column_name = 'audit_factor_conf')
            {% endif %}
            {% if count_configured_3rd_party_tracking._in_query %}
            or (t.audit_vendor_id is not null and t.audit_vendor_id != 0 and a.column_name = 'audit_vendor_id_conf')
            {% endif %}
            {% if count_configured_smoothness_upper._in_query %}
            or (t.smoothness_upper is not null and a.column_name = 'smoothness_upper_conf')
            {% endif %}
            {% if count_configured_smoothness_lower._in_query %}
            or (t.smoothness_upper is not null and a.column_name = 'smoothness_lower_conf')
            {% endif %}
            {% if count_configured_overage_threshold._in_query %}
            or (t.overage_threshold is not null and a.column_name = 'overage_threshold_conf')
            {% endif %}
        where {% condition campaign_id %} t.campaign_id {% endcondition %}

      union all

      {% endif %}

      {% if count_modified_campaign_name._in_query
        or count_modified_smoothness_upper._in_query
        or count_modified_diff_smoothness_upper._in_query
        or count_modified_smoothness_lower._in_query
        or count_modified_diff_smoothness_lower._in_query
        or count_modified_overage_threshold._in_query
        or count_modified_diff_overage_threshold._in_query
        or count_modified_pricing_type._in_query
        or count_modified_campaign_format._in_query
        or count_modified_spreader._in_query
        or count_modified_diff_spreader._in_query
        or count_modified_audit_factor._in_query
        or count_modified_diff_audit_factor._in_query
        or count_modified_3rd_party_tracking._in_query
        or count_modified_diff_3rd_party_tracking._in_query
      %}

      select
        cc.column_name,
        table_ct.__$operation as operation_type,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn as tran_lsn
      from AN_HIST..dbo_campaign_CT table_ct (nolock)
        join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
      where ct.capture_instance = 'dbo_campaign'
        and cc.column_name in (
          {% if count_modified_campaign_name._in_query %}
          'campaign_name',
          {% endif %}
          {% if count_modified_pricing_type._in_query %}
          'cpu_type_id',
          {% endif %}
          {% if count_modified_campaign_format._in_query %}
          'format_type_id',
          'device_type_id',
          {% endif %}
          {% if count_modified_spreader._in_query
            or count_modified_diff_spreader._in_query %}
          'spread_fraction',
          {% endif %}
          {% if count_modified_audit_factor._in_query
            or count_modified_diff_audit_factor._in_query %}
          'audit_factor',
          {% endif %}
          {% if count_modified_3rd_party_tracking._in_query
            or count_modified_diff_3rd_party_tracking._in_query %}
          'audit_vendor_id',
          {% endif %}
          {% if count_modified_smoothness_upper._in_query
            or count_modified_diff_smoothness_upper._in_query %}
          'smoothness_upper',
          {% endif %}
          {% if count_modified_smoothness_lower._in_query
            or count_modified_diff_smoothness_lower._in_query %}
          'smoothness_lower',
          {% endif %}
          {% if count_modified_overage_threshold._in_query
            or count_modified_diff_overage_threshold._in_query %}
          'overage_threshold',
          {% endif %}
          null
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

      union all

      {% endif %}

      {% if count_configured_custom_string._in_query %}

      select
        'custom_string_conf' as column_name,
        -1 as operation_type,
        null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_ui_setting t (nolock)
      where t.setting_key = 'CampaignInformation'
        and {% condition campaign_id %} t.campaign_id {% endcondition %}
      group by t.campaign_id

      union all

      {% endif %}

      {% if count_modified_custom_string._in_query %}

      select
        'custom_string' as column_name,
        table_ct.__$operation as operation_type,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn as tran_lsn
      from AN_HIST..dbo_campaign_ui_setting_CT table_ct (nolock)
      join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
      where ct.capture_instance = 'dbo_campaign_ui_setting'
        and table_ct.setting_key = 'CampaignInformation'
        and cc.column_name = 'setting_value'

        and table_ct.__$operation != 3

        and {% condition tran_time_raw %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_time %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_date %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_week %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_month %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_quarter %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_year %} table_ct.tran_time {% endcondition %}

        and {% condition campaign_id %} table_ct.campaign_id {% endcondition %}

      union all

      {% endif %}

      {% if count_configured_campaign_allocation_constraints._in_query %}

      select
        'constraint_conf' as column_name,
        -1 as operation_type,
        null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_constraint_v2 t (nolock)
        join "constraint" c (nolock)
          on t.constraint_id = c.constraint_id
      where c.constraint_type_id = 40
        and t.active = 1
        and {% condition campaign_id %} t.campaign_id {% endcondition %}
      group by t.campaign_id

      union all

      {% endif %}

      {% if count_modified_campaign_allocation_constraints._in_query %}


      select
        'constraint' as column_name,
        case when al.activity_type_id = 100 then 2
             when al.activity_type_id = 101 then 1
             when al.activity_type_id = 103 then 4
        end as operation_type,
        cal.createdon as tran_time,
        cal.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_activity_log cal (nolock)
        join activity_log al (nolock)
          on cal.activity_log_id = al.activity_log_id
      where al.activity_type_id in (100, 101, 103)

        and {% condition tran_time_raw %} cal.createdon {% endcondition %}
        and {% condition tran_time_time %} cal.createdon {% endcondition %}
        and {% condition tran_time_date %} cal.createdon {% endcondition %}
        and {% condition tran_time_week %} cal.createdon {% endcondition %}
        and {% condition tran_time_month %} cal.createdon {% endcondition %}
        and {% condition tran_time_quarter %} cal.createdon {% endcondition %}
        and {% condition tran_time_year %} cal.createdon {% endcondition %}

        and {% condition campaign_id %} cal.campaign_id {% endcondition %}

      union all

      {% endif %}

      {% if count_configured_objective_priority_order._in_query %}

      select
        'constraint_rank_conf' as column_name,
        -1 as operation_type,
        null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from (
        select
          ccv2.campaign_id,
          ccv2.rank as rank_ccv2,
          ctv2.rank as rank_ctv2,
          ROW_NUMBER() OVER (PARTITION BY ccv2.campaign_id ORDER BY ccv2.rank) AS row_number_ccv2,
          ROW_NUMBER() OVER (PARTITION BY ccv2.campaign_id ORDER BY ctv2.rank) AS row_number_ctv2
        from AN_MAIN..campaign_constraint_v2 ccv2 (nolock)
          join AN_MAIN.."constraint" c (nolock)
            on ccv2.constraint_id = c.constraint_id
          join AN_MAIN..constraint_type_v2 ctv2 (nolock)
            on c.constraint_type_id = ctv2.constraint_type_id
        where ccv2.active = 1
          and {% condition campaign_id %} t.campaign_id {% endcondition %}
      ) t
      where t.row_number_ccv2 != t.row_number_ctv2
      group by t.campaign_id

      union all

      {% endif %}

      {% if count_modified_objective_priority_order._in_query %}

      select top 500
        'constraint_rank' as column_name,
        4 as operation_type,
        convert(varchar, al.occurred_date, 20) as tran_time,
        cal.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_activity_log cal (nolock)
        join activity_log al (nolock)
          on cal.activity_log_id = al.activity_log_id
      where al.activity_type_id = 102

        and {% condition tran_time_raw %} cal.createdon {% endcondition %}
        and {% condition tran_time_time %} cal.createdon {% endcondition %}
        and {% condition tran_time_date %} cal.createdon {% endcondition %}
        and {% condition tran_time_week %} cal.createdon {% endcondition %}
        and {% condition tran_time_month %} cal.createdon {% endcondition %}
        and {% condition tran_time_quarter %} cal.createdon {% endcondition %}
        and {% condition tran_time_year %} cal.createdon {% endcondition %}

        and {% condition campaign_id %} cal.campaign_id {% endcondition %}
      group by
        cal.campaign_id,
        convert(varchar, al.occurred_date, 20)

      union all

      {% endif %}

      {% if count_configured_placements._in_query
        or count_configured_deals._in_query
      %}

      select
        case when pcimc.holding_partner_id is null then 'placement_conf' else 'deal_conf' end as column_name,
        -1 as operation_type,
        null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_sitelist t (nolock)
        join AN_MAIN..placement p (nolock)
          on t.placement_id = p.placement_id
        left join AN_MAIN..platform_client_internal_marketplace_connection pcimc (nolock)
          on p.partner_id = pcimc.holding_partner_id
      where {% condition campaign_id %} t.campaign_id {% endcondition %}
      group by
        t.campaign_id,
        pcimc.holding_partner_id

      union all

      {% endif %}

      {% if count_modified_placements._in_query
        or count_modified_deals._in_query
        or count_modified_diff_placements._in_query
      %}

      select
        case when pcimc.holding_partner_id is null then 'placement' else 'deal' end as column_name,
        table_ct.__$operation as operation_type,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn as tran_lsn
      from AN_HIST..dbo_campaign_sitelist_CT table_ct (nolock)
        join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
        join AN_MAIN..placement p (nolock)
          on table_ct.placement_id = p.placement_id
        left join AN_MAIN..platform_client_internal_marketplace_connection pcimc (nolock)
          on p.partner_id = pcimc.holding_partner_id
      where ct.capture_instance = 'dbo_campaign_sitelist'
        and cc.column_name = 'is_targeted'

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
        table_ct.__$operation,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn,
        pcimc.holding_partner_id

      union all

      {% endif %}

      {% if count_configured_inclusion_list._in_query
        or count_configured_exclusion_list._in_query %}

      select
        case when t.is_negative = 1 then 'exclusion_list_conf' else 'inclusion_list_conf' end as column_name,
        -1 as operation_type,
       null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_target t (nolock)
      where t.attribute_id = 114
        and {% condition campaign_id %} t.campaign_id {% endcondition %}
      group by
        t.campaign_id,
        t.is_negative

      union all

      {% endif %}

      {% if count_modified_inclusion_list._in_query
        or count_modified_exclusion_list._in_query %}

      select
        case when table_ct.is_negative = 1 then 'exclusion_list' else 'inclusion_list' end as column_name,
        table_ct.__$operation as operation_type,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn as tran_lsn
      from AN_HIST..dbo_campaign_target_CT table_ct (nolock)
      join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
      where ct.capture_instance = 'dbo_campaign_target'
        and table_ct.attribute_id = 114
        and cc.column_name = 'active'

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
        table_ct.__$operation,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn,
        table_ct.is_negative

      union all

      {% endif %}

      {% if count_configured_primary_objective._in_query
        or count_configured_secondary_objective._in_query %}

      select
        case when t.is_primary = 1 then 'primary_objective_conf' else 'secondary_objective_conf' end as column_name,
        -1 as operation_type,
        null as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_objective t (nolock)
      where {% condition campaign_id %} t.campaign_id {% endcondition %}

      union all

      {% endif %}

      {% if count_modified_primary_objective._in_query
        or count_modified_secondary_objective._in_query %}

      select
        case when table_ct.is_primary = 1 then 'primary_objective' else 'secondary_objective' end as column_name,
        table_ct.__$operation as operation_type,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn as tran_lsn
      from AN_HIST..dbo_campaign_objective_CT table_ct (nolock)
      join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
      where ct.capture_instance = 'dbo_campaign_objective'
        and cc.column_name = 'advertiser_objective_type_id'

        and table_ct.__$operation != 3

        and {% condition tran_time_raw %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_time %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_date %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_week %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_month %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_quarter %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_year %} table_ct.tran_time {% endcondition %}

        and {% condition campaign_id %} table_ct.campaign_id {% endcondition %}

      union all

      {% endif %}

      {% if count_modified_bulk_add_creatives._in_query %}

      select
        'bulk_add_creatives' as column_name,
        table_ct.__$operation as operation_type,
        convert(varchar, table_ct.tran_time, 20) as tran_time,
        null as campaign_id,
        null as tran_lsn
      from AN_HIST..dbo_media_CT table_ct (nolock)
      join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
      where ct.capture_instance = 'dbo_media'
        and cc.column_name = 'change_source'
        and table_ct.change_source = 'POST:/Customer/MediaMgmtCommand/SaveMediaAndTranscode'
        and table_ct.__$operation = 2

        and {% condition tran_time_raw %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_time %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_date %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_week %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_month %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_quarter %} table_ct.tran_time {% endcondition %}
        and {% condition tran_time_year %} table_ct.tran_time {% endcondition %}

      group by
        table_ct.__$operation,
        convert(varchar, table_ct.tran_time, 20),
        table_ct.changedby,
        convert(varchar, table_ct.changedon, 20)

      union all

      {% endif %}

      {% if count_configured_flight_start_end_dates._in_query
        or count_configured_gross_spend._in_query
        or count_configured_cpu._in_query
        or count_configured_units._in_query
      %}

      select
        a.column_name,
        -1 as operation_type,
        null tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..flight t (nolock)
        join (
          {% if count_configured_flight_start_end_dates._in_query %}
          select 'begin_end_datetm_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_gross_spend._in_query %}
          select 'planned_spend_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_cpu._in_query %}
          select 'planned_cpu_conf' as column_name
          union all
          {% endif %}
          {% if count_configured_units._in_query %}
          select 'delivery_units_conf' as column_name
          union all
          {% endif %}
          select 'placeholder' as column_name
        ) a
          on
            1 = 0
            {% if count_configured_flight_start_end_dates._in_query %}
            or (t.begin_datetm is not null and t.end_datetm is not null and a.column_name = 'begin_end_datetm_conf')
            {% endif %}
            {% if count_configured_gross_spend._in_query %}
            or (t.planned_spend > 0 and a.column_name = 'planned_spend_conf')
            {% endif %}
            {% if count_configured_cpu._in_query %}
            or (t.planned_cpu > 0 and a.column_name = 'planned_cpu_conf')
            {% endif %}
            {% if count_configured_units._in_query %}
            or (t.delivery_units > 0 and a.column_name = 'delivery_units_conf')
            {% endif %}
        where {% condition campaign_id %} t.campaign_id {% endcondition %}

      union all

      {% endif %}

      {% if count_modified_flight_start_end_dates._in_query
        or count_modified_gross_spend._in_query
        or count_modified_diff_target_spend._in_query
        or count_modified_cpu._in_query
        or count_modified_units._in_query
        or count_modified_diff_units._in_query
        or count_configured_summary_plan_pricing._in_query
        or count_modified_summary_plan_pricing._in_query
      %}

      select
        case
          when cc.column_name in ('planned_spend', 'planned_cpu', 'delivery_units')
            and table_ct.change_source = 'POST:/Customer/PlanBudgetManagement/UpdatePricing'
            then 'summary_plan_pricing'
          else cc.column_name
        end as column_name,
        table_ct.__$operation as operation_type,
        table_ct.tran_time,
        table_ct.campaign_id,
        table_ct.__$start_lsn as tran_lsn
      from AN_HIST..dbo_flight_CT table_ct (nolock)
        join cdc.captured_columns cc (nolock)
          on sys.fn_cdc_is_bit_set(cc.column_ordinal, table_ct.__$update_mask) = 1
        join cdc.change_tables ct (nolock)
          on cc.object_id = ct.object_id
      where ct.capture_instance = 'dbo_flight'
        and cc.column_name in (
          {% if count_modified_flight_start_end_dates._in_query %}
          'begin_datetm',
          'end_datetm',
          {% endif %}
          {% if count_modified_gross_spend._in_query
            or count_modified_diff_target_spend._in_query
            or count_configured_summary_plan_pricing._in_query
            or count_modified_summary_plan_pricing._in_query
          %}
          'planned_spend',
          {% endif %}
          {% if count_modified_cpu._in_query
            or count_configured_summary_plan_pricing._in_query
            or count_modified_summary_plan_pricing._in_query %}
          'planned_cpu',
          {% endif %}
          {% if count_modified_units._in_query
            or count_modified_diff_units._in_query
            or count_configured_summary_plan_pricing._in_query
            or count_modified_summary_plan_pricing._in_query %}
          'delivery_units',
          {% endif %}
          null
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

      union all

      {% endif %}

      {% if count_configured_manage_target_spend._in_query
        or count_modified_manage_target_spend._in_query
        or count_modified_diff_target_spend._in_query
        or count_configured_manage_target_units._in_query
        or count_modified_manage_target_units._in_query
        or count_modified_diff_units._in_query
        or count_configured_manage_status._in_query
        or count_modified_manage_status._in_query
        or count_configured_manage_3rd_party_tracking._in_query
        or count_modified_manage_3rd_party_tracking._in_query
        or count_modified_diff_3rd_party_tracking._in_query
        or count_configured_manage_audit_factor._in_query
        or count_modified_manage_audit_factor._in_query
        or count_modified_diff_audit_factor._in_query
        or count_configured_manage_spreader._in_query
        or count_modified_manage_spreader._in_query
        or count_modified_diff_spreader._in_query
        or count_configured_manage_smoothness_upper._in_query
        or count_modified_manage_smoothness_upper._in_query
        or count_modified_diff_smoothness_upper._in_query
        or count_configured_manage_smoothness_lower._in_query
        or count_modified_manage_smoothness_lower._in_query
        or count_modified_diff_smoothness_lower._in_query
        or count_configured_manage_overage_threshold._in_query
        or count_modified_manage_overage_threshold._in_query
        or count_modified_diff_overage_threshold._in_query
        or count_configured_manage_inventory_placements._in_query
        or count_modified_manage_inventory_placements._in_query
        or count_modified_diff_placements._in_query
      %}

      select
        case
          when comment_type_id = 28 then 'manage_target_spend'
          when comment_type_id = 62 then 'manage_target_units'
          when comment_type_id = 39 then 'manage_status'
          when comment_type_id = 40 then 'manage_3rd_party_tracking'
          when comment_type_id = 57 then 'manage_audit_factor'
          when comment_type_id = 4 then 'manage_spreader'
          when comment_type_id = 6 then 'manage_smoothness_upper'
          when comment_type_id = 5 then 'manage_smoothness_lower'
          when comment_type_id = 7 then 'manage_overage_threshold'
          when comment_type_id in (1, 2) then 'manage_inventory_placements'
        end as column_name,
        -1 as operation_type,
        t.posted_date as tran_time,
        t.campaign_id,
        null as tran_lsn
      from AN_MAIN..campaign_comment t (nolock)
      where t.comment_type_id in (
        {% if count_configured_manage_target_spend._in_query
          or count_modified_manage_target_spend._in_query
          or count_modified_diff_target_spend._in_query
        %}
        28,
        {% endif %}
        {% if count_configured_manage_target_units._in_query
          or count_modified_manage_target_units._in_query
          or count_modified_diff_units._in_query %}
        62,
        {% endif %}
        {% if count_configured_manage_status._in_query
          or count_modified_manage_status._in_query %}
        39,
        {% endif %}
        {% if count_configured_manage_3rd_party_tracking._in_query
          or count_modified_manage_3rd_party_tracking._in_query
          or count_modified_diff_3rd_party_tracking._in_query %}
        40,
        {% endif %}
        {% if count_configured_manage_audit_factor._in_query
          or count_modified_manage_audit_factor._in_query
          or count_modified_diff_audit_factor._in_query%}
        57,
        {% endif %}
        {% if count_configured_manage_spreader._in_query
          or count_modified_manage_spreader._in_query
          or count_modified_diff_spreader._in_query %}
        4,
        {% endif %}
        {% if count_configured_manage_smoothness_upper._in_query
          or count_modified_manage_smoothness_upper._in_query
          or count_modified_diff_smoothness_upper._in_query %}
        6,
        {% endif %}
        {% if count_configured_manage_smoothness_lower._in_query
          or count_modified_manage_smoothness_lower._in_query
          or count_modified_diff_smoothness_lower._in_query %}
        5,
        {% endif %}
        {% if count_configured_manage_overage_threshold._in_query
          or count_modified_manage_overage_threshold._in_query
          or count_modified_diff_overage_threshold._in_query %}
        7,
        {% endif %}
        {% if count_configured_manage_inventory_placements._in_query
          or count_modified_manage_inventory_placements._in_query
          or count_modified_diff_placements._in_query %}
        1, 2,
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
        null as operation_type,
        null as tran_time,
        null as campaign_id,
        null as tran_lsn

      {% endif %}

    ;;
  }

  dimension: column_name {
    type: string
    hidden: yes
    sql: ${TABLE}.column_name ;;
  }

  dimension: operation_type {
    type: number
    hidden: yes
    sql: ${TABLE}.operation_type ;;
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

  dimension: tran_lsn {
    hidden: yes
    sql: ${TABLE}.tran_lsn ;;
  }

  measure: count_configured_campaign_name {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'campaign_name_conf' then 1 end ;;
  }

  measure: count_modified_campaign_name {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'campaign_name' then 1 end ;;
  }

  measure: count_configured_smoothness_upper {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'smoothness_upper_conf' then 1 end ;;
  }

  measure: count_modified_smoothness_upper {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'smoothness_upper' then 1 end ;;
  }

  measure: count_configured_smoothness_lower {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'smoothness_lower_conf' then 1 end ;;
  }

  measure: count_modified_smoothness_lower {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'smoothness_lower' then 1 end ;;
  }

  measure: count_configured_overage_threshold {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'overage_threshold_conf' then 1 end ;;
  }

  measure: count_modified_overage_threshold {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'overage_threshold' then 1 end ;;
  }

  measure: count_configured_pricing_type {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'cpu_type_id_conf' then 1 end ;;
  }

  measure: count_modified_pricing_type {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'cpu_type_id' then 1 end ;;
  }

  measure: count_configured_campaign_format {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'format_device_type_id_conf' then 1 end ;;
  }

  measure: count_modified_campaign_format {
    view_label: "Count Modified (All)"
    type: count_distinct
    sql: case when ${column_name} in ('format_type_id', 'device_type_id') then cast(${campaign_id} as varchar(max)) + cast(${tran_lsn} as varchar(max)) end ;;
  }

  measure: count_configured_custom_string {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'custom_string_conf' then 1 end ;;
  }

  measure: count_modified_custom_string {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'custom_string' then 1 end ;;
  }

  measure: count_configured_placements {
    view_label: "Count Configured"
    type: sum
    sql:  case when ${column_name} = 'placement_conf' then 1 end ;;
  }

  measure: count_modified_placements {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'placement' then 1 end ;;
  }

  measure: count_configured_deals {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'deal_conf' then 1 end ;;
  }

  measure: count_modified_deals {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'deal' then 1 end ;;
  }

  measure: count_configured_inclusion_list {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'inclusion_list_conf' then 1 end ;;
  }

  measure: count_modified_inclusion_list {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'inclusion_list' then 1 end ;;
  }

  measure: count_configured_exclusion_list {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'exclusion_list_conf' then 1 end ;;
  }

  measure: count_modified_exclusion_list {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'exclusion_list' then 1 end ;;
  }

  measure: count_configured_primary_objective {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'primary_objective_conf' then 1 end ;;
  }

  measure: count_modified_primary_objective {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'primary_objective' then 1 end ;;
  }

  measure: count_configured_secondary_objective {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'secondary_objective_conf' then 1 end ;;
  }

  measure: count_modified_secondary_objective {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'secondary_objective' then 1 end ;;
  }

  measure: count_configured_spreader {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'spread_fraction_conf' then 1 end ;;
  }

  measure: count_modified_spreader {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'spread_fraction' then 1 end ;;
  }

  measure: count_configured_audit_factor {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'audit_factor_conf' then 1 end ;;
  }

  measure: count_modified_audit_factor {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'audit_factor' then 1 end ;;
  }

  measure: count_configured_3rd_party_tracking {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'audit_vendor_id_conf' then 1 end ;;
  }

  measure: count_modified_3rd_party_tracking {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'audit_vendor_id' then 1 end ;;
  }

  measure:count_configured_campaign_allocation_constraints {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'constraint_conf' then 1 end ;;
  }

  measure: count_modified_campaign_allocation_constraints {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'constraint' then 1 end ;;
  }

  measure:count_configured_objective_priority_order {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'constraint_rank_conf' then 1 end ;;
  }

  measure: count_modified_objective_priority_order {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'constraint_rank' then 1 end ;;
  }

  measure: count_configured_flight_start_end_dates {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'begin_end_datetm_conf' then 1 end ;;
  }

  measure: count_modified_flight_start_end_dates {
    view_label: "Count Modified (All)"
    type: count_distinct
    sql: case when ${column_name} in ('begin_datetm', 'end_datetm') then cast(${campaign_id} as varchar(max)) + cast(${tran_lsn} as varchar(max)) end ;;
  }

  measure: count_configured_gross_spend {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'planned_spend_conf' then 1 end ;;
  }

  measure: count_modified_gross_spend {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'planned_spend' then 1 end ;;
  }

  measure: count_configured_cpu {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'planned_cpu_conf' then 1 end ;;
  }

  measure: count_modified_cpu {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'planned_cpu' then 1 end ;;
  }

  measure: count_configured_units {
    view_label: "Count Configured"
    type: sum
    sql: case when ${column_name} = 'delivery_units_conf' then 1 end ;;
  }

  measure: count_modified_units {
    view_label: "Count Modified (All)"
    type: sum
    sql: case when ${column_name} = 'delivery_units' then 1 end ;;
  }

  measure: count_configured_summary_plan_pricing {
    view_label: "Count Configured"
    type: count_distinct
    sql: case when ${column_name} = 'summary_plan_pricing' then ${campaign_id} end ;;
  }

  measure: count_modified_summary_plan_pricing {
    view_label: "Count Modified (All)"
    type: count_distinct
    sql: case when ${column_name} = 'summary_plan_pricing' then cast(${campaign_id} as varchar(max)) + cast(${tran_lsn} as varchar(max)) end ;;
  }

  measure: count_configured_manage_target_spend {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_target_spend' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_target_spend {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_target_spend' then 1 end ;;
  }

  measure: count_modified_diff_target_spend {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_gross_spend} - ${count_modified_manage_target_spend} ;;
  }

  measure: count_configured_manage_target_units {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_target_units' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_target_units {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_target_units' then 1 end ;;
  }

  measure: count_modified_diff_units {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_units} - ${count_modified_manage_target_units} ;;
  }

  measure: count_configured_manage_status {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_status' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_status {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_status' then 1 end ;;
  }

  measure: count_configured_manage_3rd_party_tracking {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_3rd_party_tracking' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_3rd_party_tracking {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_3rd_party_tracking' then 1 end ;;
  }

  measure: count_modified_diff_3rd_party_tracking {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_3rd_party_tracking} - ${count_modified_manage_3rd_party_tracking} ;;
  }

  measure: count_configured_manage_audit_factor {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_audit_factor' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_audit_factor {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_audit_factor' then 1 end ;;
  }

  measure: count_modified_diff_audit_factor {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_audit_factor} - ${count_modified_manage_audit_factor} ;;
  }

  measure: count_configured_manage_spreader {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_spreader' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_spreader {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_spreader' then 1 end ;;
  }

  measure: count_modified_diff_spreader {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_spreader} - ${count_modified_manage_spreader} ;;
  }

  measure: count_configured_manage_smoothness_upper {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_smoothness_upper' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_smoothness_upper {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_smoothness_upper' then 1 end ;;
  }

  measure: count_modified_diff_smoothness_upper {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_smoothness_upper} - ${count_modified_manage_smoothness_upper} ;;
  }

  measure: count_configured_manage_smoothness_lower {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_smoothness_lower' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_smoothness_lower {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_smoothness_lower' then 1 end ;;
  }

  measure: count_modified_diff_smoothness_lower {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_smoothness_lower} - ${count_modified_manage_smoothness_lower} ;;
  }

  measure: count_configured_manage_overage_threshold {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_overage_threshold' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_overage_threshold {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_overage_threshold' then 1 end ;;
  }

  measure: count_modified_diff_overage_threshold {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_overage_threshold} - ${count_modified_manage_overage_threshold} ;;
  }

  measure: count_configured_manage_inventory_placements {
    view_label: "Count Configured (Manage)"
    type: count_distinct
    sql: case when ${column_name} = 'manage_inventory_placements' then ${campaign_id} end ;;
  }

  measure: count_modified_manage_inventory_placements {
    view_label: "Count Modified (Manage)"
    type: sum
    sql: case when ${column_name} = 'manage_inventory_placements' then 1 end ;;
  }

  measure: count_modified_diff_placements {
    view_label: "Count Modified (Diff between All and Manage)"
    type: number
    sql: ${count_modified_placements} - ${count_modified_manage_inventory_placements} ;;
  }

  measure: count_modified_bulk_add_creatives {
    view_label: "Count Modified (All)"
    type: sum
    description: "Number of times Bulk Add Creative was used. Filter by Modified Date column."
    sql: case when ${column_name} = 'bulk_add_creatives' then 1 end ;;
  }

  dimension: dummy_for_transposing {
    view_label: "Custom Dimensions"
    case: {
      when: {
        label: "Count Configured 3rd Party Tracking"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Audit Factor"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Campaign Allocation Constraints"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Campaign Format"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Campaign Name"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured CPU"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Custom String"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Deals"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Exclusion List"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Flight Start End Dates"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Gross Spend"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Inclusion List"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Objective Priority Order"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Overage Threshold"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Placements"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Pricing Type"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Primary Objective"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Secondary Objective"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Smoothness Lower"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Smoothness Upper"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Spreader"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Summary Plan Pricing"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Units"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage 3rd Party Tracking"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Audit Factor"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Inventory Placements"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Overage Threshold"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Smoothness Lower"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Smoothness Upper"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Spreader"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Status"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Target Spend"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Configured Manage Target Units"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified 3rd Party Tracking"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Audit Factor"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Bulk Add Creatives"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Campaign Allocation Constraints"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Campaign Format"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Campaign Name"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified CPU"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Custom String"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Deals"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Exclusion List"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Flight Start End Dates"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Gross Spend"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Inclusion List"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Objective Priority Order"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Overage Threshold"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Placements"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Pricing Type"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Primary Objective"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Secondary Objective"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Smoothness Lower"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Smoothness Upper"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Spreader"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Summary Plan Pricing"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Units"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage 3rd Party Tracking"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Audit Factor"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Inventory Placements"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Overage Threshold"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Smoothness Lower"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Smoothness Upper"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Spreader"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Status"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Target Spend"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Manage Target Units"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff 3rd Party Tracking"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Audit Factor"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Overage Threshold"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Placements"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Smoothness Lower"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Smoothness Upper"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Spreader"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Target Spend"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
      when: {
        label: "Count Modified Diff Units"
        sql: ${campaign_id} = ${campaign_id} ;;
      }
    }
  }
}
