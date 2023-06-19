view: insight_object_team {
  derived_table: {
    sql:
      SELECT
        oa."OBJECT_ID",
        oav."OBJECT_ATTRIBUTE_ID",
        oav."TEXT_VALUE"
      FROM
        public."AO_8542F1_IFJ_OBJ_ATTR" oa,
        public."AO_8542F1_IFJ_OBJ_ATTR_VAL" oav
      WHERE
        oa."ID" = oav."OBJECT_ATTRIBUTE_ID" AND
        oa."OBJECT_TYPE_ATTRIBUTE_ID" = 3659
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

  dimension: team {
    type: string
    label: "Team"
    view_label: "Insight Fields"
    sql: ${TABLE}."TEXT_VALUE" ;;
  }
}
