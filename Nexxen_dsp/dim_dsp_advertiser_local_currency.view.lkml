view: dim_dsp_advertiser_local_currency {
  sql_table_name: BI_DSP.dim_dsp_advertiser_local_currency ;;

  dimension: advertiser_local_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_local_currency_id ;;
  }
  dimension: advertiser_local_currency_iso {
    type: string
    label: "DSP Advertiser Currency ISO"
    description: "The ISO currency code representing the advertiser’s local currency as defined and configured in the DSP."
    sql: ${TABLE}.advertiser_local_currency_iso ;;
  }
  dimension: advertiser_local_currency_key {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_local_currency_key ;;
  }
}
