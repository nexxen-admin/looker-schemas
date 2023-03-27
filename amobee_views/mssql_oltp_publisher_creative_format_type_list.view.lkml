view: mssql_oltp_publisher_creative_format_type_list {
  label: "Publisher Creative Types List"
  derived_table: {
    sql:
      SELECT
        partner_id,
        STUFF(
          (
            SELECT ', ' + cft.description
            FROM publisher_creative_format_type pcft1 (NOLOCK)
              JOIN creative_format_type cft (NOLOCK)
                ON pcft1.creative_format_type_id = cft.creative_format_type_id
            WHERE pcft1.partner_id = pcft2.partner_id
              AND pcft1.active = 1
            FOR XML PATH ('')
          ), 1, 2, ''
        ) AS creative_format_types_descriptions_list
      FROM publisher_creative_format_type pcft2 (NOLOCK)
      GROUP BY partner_id
    ;;
  }

  dimension: partner_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: creative_format_types_descriptions_list {
    type: string
    label: "Creative Types List"
    sql: ${TABLE}.creative_format_types_descriptions_list ;;
  }
}
