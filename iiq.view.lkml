
view: iiq {
  derived_table: {
    sql: select distinct coalesce(iiq.event_date, iiq_control.event_date) as event_date, 
        coalesce(iiq.dsp_account, iiq_control.dsp_account) as dsp_account,
        coalesce(iiq.imptype, iiq_control.imptype) as imptype,
        coalesce(iiq.device, iiq_control.device) as device,
        coalesce(iiq.mediatype, iiq_control.mediatype) as mediatype,
        iiq.requests as requests_iiq,
        iiq.impressions as impressions_iiq,
        iiq.revenue as revenue_iiq, 
        iiq.rev_factor as rev_factor_iiq, 
        (iiq.impressions/iiq.requests) as fill_iiq, 
        (iiq.revenue/iiq.impressions)*1000 as cpm_iiq,
        iiq_control.requests as requests_iiq_control, 
        iiq_control.impressions as impressions_iiq_control,
        iiq_control.revenue as revenue_iiq_control, 
        iiq_control.rev_factor as rev_factor_iiq_control, 
        (iiq_control.impressions/iiq_control.requests) as fill_iiq_control, 
        (iiq_control.revenue/iiq_control.impressions)*1000 as cpm_iiq_control,
        (iiq.rev_factor/iiq_control.rev_factor)::decimal(10,4) as ratio,
        coalesce((iiq.rev_factor/iiq_control.rev_factor)::decimal(10,4)-1,1) as ratio_1, 
        (iiq.revenue/coalesce(((iiq.rev_factor/iiq_control.rev_factor)::decimal(10,4)),1))*coalesce((((iiq.rev_factor/iiq_control.rev_factor)::decimal(10,4))-1),1) as lift_iiq_control
      from (
          select jir.*, 
            jii.impressions, 
            jii.revenue, 
            ((impressions/requests) *((revenue/impressions)*1000)) as rev_factor 
          from BI_New.jc_iiq_request jir 
            left outer join BI_New.jc_iiq_imps jii on jir.event_date = jii.event_date
                                and jir.dsp_account =jii.dsp_account  
                                and jir.imptype =jii.imptype 
                                and jir.uidsource  = jii.uidsource  
                                and jir.device  = jii.device 
                                and jir.mediatype  = jii.mediatype 
          where jir.uidsource ='iiq_api'
            and jir.event_date = CURRENT_DATE - INTERVAL '1' DAY
          ) as iiq
      full join (
          select jir.*, 
            jii.impressions, 
            jii.revenue, 
            ((impressions/requests) *((revenue/impressions)*1000)) as rev_factor 
          from BI_New.jc_iiq_request jir 
            left outer join BI_New.jc_iiq_imps jii on jir.event_date = jii.event_date
                                and jir.dsp_account =jii.dsp_account  
                                and jir.imptype =jii.imptype 
                                and jir.uidsource  = jii.uidsource  
                                and jir.device  = jii.device 
                                and jir.mediatype  = jii.mediatype 
          WHERE jir.uidsource = 'iiq_api_unused'
                AND jir.event_date = CURRENT_DATE - INTERVAL '1' DAY
          ) as iiq_control on iiq.event_date = iiq_control.event_date
                  and iiq.dsp_account =iiq_control.dsp_account  
                  and iiq.imptype =iiq_control.imptype  
                  and iiq.device  = iiq_control.device 
                  and iiq.mediatype  = iiq_control.mediatype
      where iiq.device ='ctv'
      order by iiq.revenue desc ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event_date {
    type: time
    sql: ${TABLE}.event_date ;;
  }

  dimension: dsp_account {
    type: string
    sql: ${TABLE}.dsp_account ;;
  }

  dimension: imptype {
    type: string
    sql: ${TABLE}.imptype ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: mediatype {
    type: string
    sql: ${TABLE}.mediatype ;;
  }

  dimension: requests_iiq {
    type: number
    sql: ${TABLE}.requests_iiq ;;
  }

  dimension: impressions_iiq {
    type: number
    sql: ${TABLE}.impressions_iiq ;;
  }

  dimension: revenue_iiq {
    type: number
    sql: ${TABLE}.revenue_iiq ;;
  }

  dimension: rev_factor_iiq {
    type: number
    sql: ${TABLE}.rev_factor_iiq ;;
  }

  dimension: fill_iiq {
    type: number
    sql: ${TABLE}.fill_iiq ;;
  }

  dimension: cpm_iiq {
    type: number
    sql: ${TABLE}.cpm_iiq ;;
  }

  dimension: requests_iiq_control {
    type: number
    sql: ${TABLE}.requests_iiq_control ;;
  }

  dimension: impressions_iiq_control {
    type: number
    sql: ${TABLE}.impressions_iiq_control ;;
  }

  dimension: revenue_iiq_control {
    type: number
    sql: ${TABLE}.revenue_iiq_control ;;
  }

  dimension: rev_factor_iiq_control {
    type: number
    sql: ${TABLE}.rev_factor_iiq_control ;;
  }

  dimension: fill_iiq_control {
    type: number
    sql: ${TABLE}.fill_iiq_control ;;
  }

  dimension: cpm_iiq_control {
    type: number
    sql: ${TABLE}.cpm_iiq_control ;;
  }

  dimension: ratio {
    type: number
    sql: ${TABLE}.ratio ;;
  }

  dimension: ratio_1 {
    type: number
    sql: ${TABLE}.ratio_1 ;;
  }

  dimension: lift_iiq_control {
    type: number
    sql: ${TABLE}.lift_iiq_control ;;
  }

  set: detail {
    fields: [
        event_date_time,
	dsp_account,
	imptype,
	device,
	mediatype,
	requests_iiq,
	impressions_iiq,
	revenue_iiq,
	rev_factor_iiq,
	fill_iiq,
	cpm_iiq,
	requests_iiq_control,
	impressions_iiq_control,
	revenue_iiq_control,
	rev_factor_iiq_control,
	fill_iiq_control,
	cpm_iiq_control,
	ratio,
	ratio_1,
	lift_iiq_control
    ]
  }
}
