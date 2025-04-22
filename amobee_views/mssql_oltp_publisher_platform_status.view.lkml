view: mssql_oltp_publisher_platform_status {
  derived_table: {
    sql:
      SELECT
        pa.partner_id,
        pa.active,
        SUM(CASE WHEN p.placement_is_paused = 0 AND p.active = 1 THEN 1 ELSE 0 END) AS partner_count_active_placements
      FROM partner pa (NOLOCK)
        LEFT JOIN placement p (NOLOCK)
          ON pa.partner_id = p.partner_id
      GROUP BY
        pa.partner_id,
        pa.active
    ;;
  }

  dimension: partner_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: partner_count_active_placements {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_count_active_placements ;;
  }

  dimension: platform_publisher_active {
    type: string
    view_label: "Platform Dimensions"
    label: "Publisher Status"
    sql: CASE WHEN NOT ${active} THEN 'Deleted'
              ELSE CASE WHEN ${partner_count_active_placements} > 0 THEN 'Active'
                        ELSE 'Inactive'
                   END
         END ;;
    suggestions: ["Active","Inactive","Deleted"]
  }
}
