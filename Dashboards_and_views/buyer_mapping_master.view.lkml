
view: buyer_mapping_master {
  derived_table: {
    sql: Select BUYER_ORIGINAL as "Original Value",
        Length(BUYER_ORIGINAL)as "Original - Character Count",
        BUYER_NEW as "New Value",
        Length(BUYER_NEW)as "New Value - Character Count"
      From BI.SVC_Buyer_Mapping_Master
      Order by 1, 3 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: original_value {
    type: string
    label: "Original Value"
    sql: ${TABLE}."Original Value" ;;
  }

  dimension: original__character_count {
    type: number
    label: "Original - Character Count"
    sql: ${TABLE}."Original - Character Count" ;;
  }

  dimension: new_value {
    type: string
    label: "New Value"
    sql: ${TABLE}."New Value" ;;
  }

  dimension: new_value__character_count {
    type: number
    label: "New Value - Character Count"
    sql: ${TABLE}."New Value - Character Count" ;;
  }

  set: detail {
    fields: [
        original_value,
	original__character_count,
	new_value,
	new_value__character_count
    ]
  }
}
