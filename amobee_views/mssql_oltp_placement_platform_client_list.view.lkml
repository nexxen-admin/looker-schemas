view: mssql_oltp_placement_platform_client_list {
  label: "Placement Platform Clients List"
  derived_table: {
    sql:
      SELECT
        placement_id,
        COUNT(*) AS count_platform_clients,
        STUFF(
          (
            SELECT ', ' + pc.description
            FROM placement_platform_client ppc1 (NOLOCK)
              JOIN platform_client pc (NOLOCK)
                ON ppc1.platform_client_id = pc.platform_client_id
            WHERE ppc1.placement_id = ppc2.placement_id
              AND ppc1.active = 1
            FOR XML PATH ('')
          ), 1, 2, ''
        ) AS platform_clients_list
      FROM placement_platform_client ppc2 (NOLOCK)
      WHERE ppc2.active = 1
      GROUP BY placement_id
    ;;
  }

  dimension: placement_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: count_platform_clients {
    type: number
    hidden: yes
    sql: ${TABLE}.count_platform_clients ;;
  }

  dimension: platform_clients_list {
    type: string
    label: "Platform Clients List"
    sql: ${TABLE}.platform_clients_list ;;
  }
}
