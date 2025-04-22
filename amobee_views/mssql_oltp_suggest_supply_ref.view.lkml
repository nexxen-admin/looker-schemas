view: mssql_oltp_suggest_supply_ref {
  derived_table: {
    sql:
   select
      pl.placement_name,
      pr.partner_name,
      ofc.office_name,
      br.description as business_region,
      pl.country_id,
      ctpl.description as country_name,
      crpr.currency_name as partner_currency,
      crpr.currency_abbreviation as partner_currency_abbreviation,
      sg.description as site_genre,
      pt.description as placement_type,
      it.description as placement_inventory_type,
      fot.description as format_type,
      art.description as approval_review_type,
      pr.platform_client_id
    from dbo.placement (NOLOCK) pl
    left join dbo.partner (NOLOCK) pr on pl.partner_id = pr.partner_id
    left join dbo.office (NOLOCK) ofc on pr.office_id = ofc.office_id
    left join dbo.business_region (NOLOCK) br on pr.business_region_id = br.business_region_id
    left join dbo.country (NOLOCK) ctpl on pl.country_id = ctpl.country_id
    left join dbo.currency (NOLOCK) crpr on pr.preferred_currency_id = crpr.currency_id
    left join dbo.site_genre (NOLOCK) sg on pl.site_genre_id = sg.site_genre_id
    left join dbo.placement_type (NOLOCK) pt on pl.placement_type_id = pt.placement_type_id
    left join dbo.placement_inventory_type (NOLOCK) it on pl.placement_inventory_type_id = it.placement_inventory_type_id
    left join dbo.format_type (NOLOCK) fot on pl.format_type_id = fot.format_type_id
    left join dbo.approval_review_type (NOLOCK) art on pr.approval_review_type_id = art.approval_review_type_id
    left join dbo.platform_client (NOLOCK) pc on pr.platform_client_id = pc.platform_client_id
     ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: partner_name {
    type: string
    sql: ${TABLE}.partner_name ;;
  }

  dimension: office_name {
    type: string
    sql: ${TABLE}.office_name ;;
  }

  dimension: business_region {
    type: string
    sql: ${TABLE}.business_region ;;
  }

  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }

  dimension: partner_currency {
    type: string
    sql: ${TABLE}.partner_currency ;;
  }

  dimension: partner_currency_abbreviation {
    type: string
    sql: ${TABLE}.partner_currency_abbreviation ;;
  }

  dimension: site_genre {
    type: string
    sql: ${TABLE}.site_genre ;;
  }

  dimension: placement_type {
    type: string
    sql: ${TABLE}.placement_type ;;
  }

  dimension: placement_inventory_type {
    type: string
    sql: ${TABLE}.placement_inventory_type ;;
  }

  dimension: format_type {
    type: string
    sql: ${TABLE}.format_type ;;
  }

  dimension: approval_review_type {
    type: string
    sql: ${TABLE}.approval_review_type ;;
  }

  dimension: platform_client_id {
    type: number
    sql: ${TABLE}.platform_client_id ;;
  }
}
