view: insight_object_status {
  derived_table: {
    sql:
      SELECT
        oa."OBJECT_ID",
        oav."OBJECT_ATTRIBUTE_ID",
        ro."NAME"
      FROM
        "AO_8542F1_IFJ_OBJ_ATTR" oa,
        "AO_8542F1_IFJ_OBJ_ATTR_VAL" oav,
        "AO_8542F1_IFJ_OBJ" ro
      WHERE
        oa."ID" = oav."OBJECT_ATTRIBUTE_ID"
        AND oav."REFERENCED_OBJECT_ID" = ro."ID"
        AND oa."OBJECT_TYPE_ATTRIBUTE_ID" = 3683
    ;;
  }

  dimension: attribute_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."OBJECT_ATTRIBUTE_ID" ;;
  }

  dimension: object_id {
    type: number
    hidden: yes
    sql: ${TABLE}."OBJECT_ID" ;;
  }

  dimension: status {
    type: yesno
    label: "Is Active"
    view_label: "Insight Fields"
    sql: ${TABLE}."NAME" = 'Active' ;;
  }
}
