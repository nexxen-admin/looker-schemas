view: mssql_oltp_partner_xml_xf_type_list {
  label: "Partner Integration Types List"
  derived_table: {
    sql:
      SELECT
        partner_id,
        COUNT(*) AS count_xml_xf_types,
        STUFF(
          (
            SELECT ', ' + xxt.xml_xf_type_description
            FROM partner_xml_xf_type pxxt1 (NOLOCK)
              JOIN xml_xf_type xxt (NOLOCK)
                ON pxxt1.xml_xf_type_id = xxt.xml_xf_type_id
            WHERE pxxt1.partner_id = pxxt2.partner_id
              AND pxxt1.active = 1
            FOR XML PATH ('')
          ), 1, 2, ''
        ) AS xml_xf_types_descriptions_list
      FROM partner_xml_xf_type pxxt2 (NOLOCK)
      WHERE pxxt2.active = 1
      GROUP BY partner_id
    ;;
  }

  dimension: partner_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: count_xml_xf_types {
    type: number
    hidden: yes
    sql: ${TABLE}.count_xml_xf_types ;;
  }

  dimension: preview_xml {
    type: yesno
    label: "Preview XML"
    sql: ${count_xml_xf_types} > 0 ;;
  }

  dimension: xml_xf_types_descriptions_list {
    type: string
    label: "Integration Types List"
    sql: ${TABLE}.xml_xf_types_descriptions_list ;;
  }
}
