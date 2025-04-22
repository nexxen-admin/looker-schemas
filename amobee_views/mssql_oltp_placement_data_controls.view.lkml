view: mssql_oltp_placement_data_controls {
  label: "Placement Data Controls"
  derived_table: {
    sql:
      SELECT
        pl.placement_id,
        pl_dc.explicit_geo AS explicit_geo_placement,
        pl_dc.use_cookies AS use_cookies_placement,
        pl_dc.add_trackers AS add_trackers_placement,
        pl_dc.permit_third_party_sync AS permit_third_party_sync_placement,
        pl_dc.override_partner_tracking_domain_list,
        pl_dc.tracking_domain_list_id AS tracking_domain_list_id_placement,
        p_dc.explicit_geo AS explicit_geo_partner,
        p_dc.use_cookies AS use_cookies_partner,
        p_dc.add_trackers AS add_trackers_partner,
        p_dc.permit_third_party_sync AS permit_third_party_sync_partner,
        p_tdl.tracking_domain_list_name AS tracking_domain_list_name_partner,
        pl_tdl.tracking_domain_list_name AS tracking_domain_list_name_placement
      FROM dbo.placement pl (NOLOCK)
        LEFT JOIN dbo.placement_data_controls pl_dc (NOLOCK)
          ON pl.placement_id = pl_dc.placement_id AND pl_dc.active = 1
        LEFT JOIN dbo.partner_data_controls p_dc (NOLOCK)
          ON pl.partner_id = p_dc.partner_id AND p_dc.active = 1
        LEFT JOIN dbo.partner_tracking_domain_list ptdl (NOLOCK)
          ON p_dc.partner_id = ptdl.partner_id AND ptdl.active = 1
        LEFT JOIN tracking_domain_list p_tdl (NOLOCK)
          ON ptdl.tracking_domain_list_id = p_tdl.tracking_domain_list_id
        LEFT JOIN tracking_domain_list pl_tdl (NOLOCK)
          ON pl_dc.tracking_domain_list_id = pl_tdl.tracking_domain_list_id
    ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: explicit_geo_override_publisher {
    type: yesno
    label: "Explicit Geo - Override inherited setting from publisher"
    sql: ${TABLE}.explicit_geo_placement IS NOT NULL ;;
  }

  dimension: explicit_geo {
    type: yesno
    label: "Explicit Geo"
    sql: CASE WHEN ${explicit_geo_override_publisher} THEN ${TABLE}.explicit_geo_placement
              ELSE ${TABLE}.explicit_geo_partner
         END = 1 ;;
  }

  dimension: use_cookies_override_publisher {
    type: yesno
    label: "Use Cookies - Override inherited setting from publisher"
    sql: ${TABLE}.use_cookies_placement IS NOT NULL ;;
  }

  dimension: use_cookies {
    type: yesno
    label: "Use Cookies"
    sql: CASE WHEN ${use_cookies_override_publisher} THEN ${TABLE}.use_cookies_placement
              ELSE ${TABLE}.use_cookies_partner
         END = 1 ;;
  }

  dimension: add_trackers_override_publisher {
    type: yesno
    label: "Add Trackers - Override inherited setting from publisher"
    sql: ${TABLE}.add_trackers_placement IS NOT NULL ;;
  }

  dimension: add_trackers {
    type: yesno
    label: "Add Trackers"
    sql: CASE WHEN ${add_trackers_override_publisher} THEN ${TABLE}.add_trackers_placement
              ELSE ${TABLE}.add_trackers_partner
         END = 1 ;;
  }

  dimension: permit_third_party_sync_override_publisher {
    type: yesno
    label: "Permit Third Party Sync - Override inherited setting from publisher"
    sql: ${TABLE}.permit_third_party_sync_placement IS NOT NULL ;;
  }

  dimension: permit_third_party_sync {
    type: yesno
    label: "Permit Third Party Sync"
    sql: CASE WHEN ${permit_third_party_sync_override_publisher} THEN ${TABLE}.permit_third_party_sync_placement
              ELSE ${TABLE}.permit_third_party_sync_partner
         END = 1 ;;
  }

  dimension: override_partner_tracking_domain_list {
    type: yesno
    label: "Permitted Vendors List - Override inherited setting from publisher"
    sql: ${TABLE}.override_partner_tracking_domain_list = 1 ;;
  }

  dimension: tracking_domain_list_name {
    type: string
    label: "Permitted Vendors List"
    sql: CASE WHEN ${override_partner_tracking_domain_list} THEN ${TABLE}.tracking_domain_list_name_placement
              ELSE ${TABLE}.tracking_domain_list_name_partner
         END ;;
  }
}
