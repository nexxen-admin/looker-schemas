view: sla_lookup {
    sql_table_name: SLA_LOOKUP ;;

    dimension: sla_lookup_id {
      type: string
      sql: ${TABLE}.sla_lookup_id ;;
    }

    dimension: lookup_key {
      type: string
      sql: ${TABLE}.lookup_key ;;
    }

    dimension: lookup_value {
      type: string
      sql: ${TABLE}.lookup_value ;;
    }

    dimension: provider_name {
      type: string
      sql: coalesce(${TABLE}.lookup_value, 'Other') ;;
    }

    dimension: client_name {
      type: string
      sql: coalesce(${TABLE}.lookup_value, 'Other') ;;
    }

    measure: count {
      type: count
      drill_fields: []
    }
  }
