view: collider_attribute_values {

    derived_table: {
      sql: SELECT
  udv.user_data_vendor_id,
  udv.description as data_vendor_name,
  t1.retargeting_attribute_id,
  t1.retargeting_attribute_name,
  dvc.data_vendor_cost_id,
  dvc.description  AS data_vendor_cost_description,
  dvct.data_vendor_cost_type_id,
  dvct.description AS data_vendor_cost_type_id_description
FROM AN_MAIN..retargeting_attribute t1
INNER JOIN AN_MAIN..user_data_vendor udv
  ON t1.ref_key_id = udv.user_data_vendor_id AND udv.user_data_vendor_id = 154
INNER JOIN AN_MAIN..data_vendor_cost dvc
  ON dvc.user_data_vendor_id = udv.user_data_vendor_id
INNER JOIN AN_MAIN..data_vendor_cost_type dvct
  ON dvc.data_vendor_cost_type_id = dvct.data_vendor_cost_type_id;;
    }

    dimension: user_data_vendor_id {
      type: string
      hidden: yes
      sql: ${TABLE}.user_data_vendor_id ;;
    }

    dimension: data_vendor_name {
      type: string
      label: "Data Provider"
      #view_label: "Objects"
      description: "The name data provider for the retargeting attributed"
      sql: ${TABLE}.data_vendor_name;;

      }

    dimension: retargeting_attribute_id {
      type: string
      hidden: yes
      sql: ${TABLE}.retargeting_attribute_id ;;
    }

  dimension: retargeting_attribute_name {
    type: string
    label: "Retargeting Attribute"
    description: "The name of the Retargeting Attribute"
    sql: ${TABLE}.retargeting_attribute_name ;;
  }


  dimension: data_vendor_cost_id {
    type: string
    hidden: yes
    sql: ${TABLE}.data_vendor_cost_id ;;
  }


  dimension: data_vendor_cost_description {
    type: string
    #hidden: yes
    sql: ${TABLE}.data_vendor_cost_description ;;
  }

  dimension: data_vendor_cost_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.data_vendor_cost_type_id ;;
  }


  dimension: data_vendor_cost_type {
    type: string
    sql: ${TABLE}.data_vendor_cost_type_id_description ;;
  }


  }
