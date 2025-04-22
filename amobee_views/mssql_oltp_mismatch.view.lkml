view: mssql_oltp_mismatch {
   derived_table: {
     sql: SELECT
            p2.partner_id,
            fm.flight_media_id
          FROM
            dbo.cache_targeted_placement_view ctpv (NOLOCK)
              JOIN dbo.placement p (NOLOCK)
                ON ctpv.placement_id = p.placement_id
              JOIN dbo.partner p2 (NOLOCK)
                ON p.partner_id = p2.partner_id
              JOIN dbo.flight_media fm (NOLOCK)
                ON ctpv.target_id = fm.flight_media_id
              JOIN dbo.flight f (NOLOCK)
                ON fm.flight_id = f.flight_id
              JOIN dbo.campaign c (NOLOCK)
                ON f.campaign_id = c.campaign_id
              JOIN dbo.platform_client pc (NOLOCK)
                ON c.platform_client_id = pc.platform_client_id
              JOIN dbo.office o (NOLOCK)
                ON pc.office_id = o.office_id
              JOIN
              (
                SELECT
                  p3.partner_id,
                  COUNT(p3.placement_id) AS placement_count
                FROM
                  dbo.placement p3 (NOLOCK)
                GROUP BY
                  p3.partner_id
              ) AS t
                ON p2.partner_id = t.partner_id
          WHERE
            p.is_test_placement = 0 AND
            p2.approval_type_id in (2, 3) AND
            fm.active = 1 AND
            {% condition demand_platform_client_office.office_name %} o.office_name {% endcondition %}
          GROUP BY
            p2.partner_id,
            fm.flight_media_id
          HAVING
            MAX(ctpv.is_approved) = 0 AND
            COUNT(p.placement_id) < MAX(t.placement_count) ;;
  }

  dimension: partner_id {
    type: number
    view_label: "Custom Dimensions"
    label: "Mismatch Partner ID"
    sql: ${TABLE}.partner_id ;;
    value_format_name: id
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }
}
