view: mssql_oltp_expression_document_plain_bda {
  derived_table: {
    sql: select
      expression_document_id,
      CONCAT(t1.gender_result,
          CONCAT(MIN(SUBSTRING(expression_group_item, CHARINDEX('[', expression_group_item) + 1, CHARINDEX(',', expression_group_item) - CHARINDEX('[', expression_group_item) - 1)),
          CASE WHEN MAX(SUBSTRING(expression_group_item, CHARINDEX(',', expression_group_item) + 1, CHARINDEX(']', expression_group_item) - CHARINDEX(',', expression_group_item) - 1))= '' THEN '+' ELSE '-' END,
          MAX(SUBSTRING(expression_group_item, CHARINDEX(',', expression_group_item) + 1, CHARINDEX(']', expression_group_item) - CHARINDEX(',', expression_group_item) - 1)))
        ) as buy_demo_audience_definition
      FROM dbo.expression_document_plain as t
      join (
        SELECT expression_document_id as edi,
              REPLACE(REPLACE(STRING_AGG(REPLACE(REPLACE(expression_group_item, 'FM', 'A'), 'MF', 'A'), ''), 'FM', 'A'), 'MF', 'A') AS gender_result
        FROM dbo.expression_document_plain
        WHERE expression_group_type ='GENDER'
        GROUP BY expression_document_id
      ) as t1 on t.expression_document_id= t1.edi
  WHERE expression_group_type ='AGE'
  GROUP BY t.expression_document_id ,gender_result ;;
  }

  dimension: expression_document_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.expression_document_id ;;
  }

  dimension: buy_demo_audience_definition {
    type: string
    label: "Buy Demo Audience Definition"
    view_label: "Campaign"
    sql: ${TABLE}.buy_demo_audience_definition ;;
  }

}
