view: xf_third_party_placements_deal {
  label: "Third Party Data"
  derived_table: {
    sql:  SELECT
            p2.placement_id,
            COUNT(p2.third_party_id) AS count_deals,
            STUFF((
              SELECT
                ', ' + p.third_party_type_id
              FROM
                dbo.XF_Third_Party_Placements p (NOLOCK)
              WHERE
                p.third_party_type = 'Deal' AND
                p.third_party_type_id <> '' AND
                p.active = 1 AND
                p.placement_id = p2.placement_id
              ORDER BY
                p.third_party_type_id
              FOR XML PATH('')), 1, 2, '') AS deal
          FROM
            dbo.XF_Third_Party_Placements p2 (NOLOCK)
          WHERE
            p2.third_party_type = 'Deal' AND
            p2.third_party_type_id <> '' AND
            p2.active = 1
          GROUP BY
            p2.placement_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: deal {
    type: string
    label: "Exchange Deal ID"
    sql: ${TABLE}.deal ;;
  }

  dimension: count_deals {
    type: number
    hidden: yes
    sql: ${TABLE}.count_deals ;;
  }

  dimension: is_deal_id_placement {
    type: yesno
    label: "Placement Is DealID"
    view_label: "Placement"
    sql: ${count_deals} > 0 ;;
  }
}
