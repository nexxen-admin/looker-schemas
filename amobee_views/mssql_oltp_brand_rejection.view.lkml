view: brand_rejection {

  derived_table: {
    sql:  SELECT v.partner_id AS partner_id
    ,v.partner_name AS partner_name
    ,NULL AS placement_id
    ,NULL AS placement_name
    ,advertiser_brand_id
    ,v.Advertiser
    ,v.Brand
    ,'Rejected' AS alert_type
    ,v.office_id AS office_id
  FROM an_main..ssp_approval_history_by_brand_view v
  LEFT JOIN an_main..placement_approval pa ON v.publisher_approval_id = pa.publisher_approval_id
  WHERE v.approval_status_id IN (3)
    AND isnull(v.changedon, v.createdon) > dateadd(dd, - 1, GETDATE())

  UNION

  SELECT v.partner_id AS partner_id
    ,v.partner_name AS partner_name
    ,pa.placement_id AS placement_id
    ,p.placement_name AS placement_name
    ,advertiser_brand_id
    ,v.Advertiser
    ,v.Brand
    ,'Rejected' AS alert_type
    ,v.office_id AS office_id
  FROM an_main..ssp_approval_history_by_brand_view v
  JOIN an_main..placement_approval pa ON v.publisher_approval_id = pa.publisher_approval_id
    AND pa.active = 1
  JOIN an_main..placement p ON pa.placement_id = p.placement_id
  WHERE pa.approval_status_id IN (3)
    AND v.approval_status_id IN (4)
    AND isnull(v.changedon, v.createdon) > dateadd(dd, - 1, GETDATE())

  UNION

  SELECT v.partner_id AS partner_id
    ,v.partner_name AS partner_name
    ,NULL AS placement_id
    ,NULL AS placement_name
    ,advertiser_brand_id
    ,v.Advertiser
    ,v.Brand
    ,'Approved with blocked duration' AS alert_type
    ,v.office_id AS office_id
  FROM an_main..ssp_approval_history_by_brand_view v
  LEFT JOIN an_main..placement_approval pa ON v.publisher_approval_id = pa.publisher_approval_id
  WHERE v.approval_status_id IN (5)
    AND isnull(v.changedon, v.createdon) > dateadd(dd, - 1, GETDATE())

  UNION

  SELECT v.partner_id AS partner_id
    ,v.partner_name AS partner_name
    ,pa.placement_id AS placement_id
    ,p.placement_name AS placement_name
    ,advertiser_brand_id
    ,v.Advertiser
    ,v.Brand
    ,'Approved with blocked duration' AS alert_type
    ,v.office_id AS office_id
  FROM an_main..ssp_approval_history_by_brand_view v
  JOIN an_main..placement_approval pa ON v.publisher_approval_id = pa.publisher_approval_id
    AND pa.active = 1
  JOIN an_main..placement p ON pa.placement_id = p.placement_id
  WHERE pa.approval_status_id IN (5)
    AND v.approval_status_id IN (4)
    AND isnull(v.changedon, v.createdon) > dateadd(dd, - 1, GETDATE())
      ;;
  }


  dimension: partner_id {
    type: number
    label: "Publisher ID"
    sql: ${TABLE}.partner_id ;;
    value_format_name: id
  }

  dimension: partner_name {
    type: string
    label: "Publisher"
    sql: ${TABLE}.partner_name ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: advertiser {
    type: string
    sql: ${TABLE}.advertiser ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_brand_id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: alert_type {
    type: string
    sql: ${TABLE}.alert_type ;;
  }


  dimension: office_id {
    type: number
    sql: ${TABLE}.office_id ;;
    value_format_name: id
  }

}
