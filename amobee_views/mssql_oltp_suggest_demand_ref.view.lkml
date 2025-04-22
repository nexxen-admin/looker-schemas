view: mssql_oltp_suggest_demand_ref {
  derived_table: {
    sql: select
      cd.campaign_name,
      ct.description as campaign_type,
      cp.description as cpu_type,
      io.insertion_order_name,
      pc.description as demand_platform_client,
      pg.description as demand_platform_client_group,
      pc.platform_client_id,
      c.country_id,
      c.customer_name,
      o.office_name,
      ab.brand_name,
      a.advertiser_name,
      pl.plan_name,
      br.description AS business_region,
      tz.description as timezone
    from dbo.campaign (NOLOCK) cd
    left join dbo.campaign_type (NOLOCK) ct on cd.campaign_type_id = ct.campaign_type_id
    left join dbo.cpu_type (NOLOCK) cp on cd.cpu_type_id = cp.cpu_type_id
    left join dbo.platform_client (NOLOCK) pc on cd.platform_client_id = pc.platform_client_id
    left join dbo.platform_client_group (NOLOCK) pg on pc.platform_client_group_id = pg.platform_client_group_id
    left join dbo.customer (NOLOCK) c on cd.customer_id = c.customer_id
    left join dbo.office (NOLOCK) o on pc.office_id = o.office_id
    left join dbo.advertiser_brand (NOLOCK) ab on cd.advertiser_brand_id = ab.advertiser_brand_id
    left join dbo.advertiser (NOLOCK) a on ab.advertiser_id = a.advertiser_id
    left join dbo.pl_plan (NOLOCK) pl on cd.pl_plan_id = pl.pl_plan_id
    left join dbo.timezone (NOLOCK) tz on cd.timezone_id = tz.timezone_id
    left join dbo.business_region (NOLOCK) br on pc.business_region_id = br.business_region_id
    left join dbo.insertion_order (NOLOCK) io on cd.insertion_order_id = io.insertion_order_id ;;
  }

  dimension: platform_client_id {
    type: number
    sql: ${TABLE}.platform_client_id ;;
    value_format_name: id
  }

  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
    value_format_name: id
  }

  dimension: demand_platform_client {
    type: string
    sql: ${TABLE}.demand_platform_client ;;
  }

  dimension: demand_platform_client_group {
    type: string
    sql: ${TABLE}.demand_platform_client_group ;;
  }

  dimension: office_name {
    type: string
    sql: ${TABLE}.office_name ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: plan_name {
    type: string
    sql: ${TABLE}.plan_name ;;
  }

  dimension: campaign_type {
    type: string
    sql: ${TABLE}.campaign_type ;;
  }

  dimension: cpu_type {
    type: string
    sql: ${TABLE}.cpu_type ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: business_region {
    type: string
    sql: ${TABLE}.business_region ;;
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
}
