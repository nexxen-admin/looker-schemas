view: v_campaign_geolocation {
  label: "Campaign"
  derived_table: {
    sql: SELECT
          ct.campaign_id,
          LISTAGG( DISTINCT geo.dma_description, ', ') as dma_description
         FROM DIM.CAMPAIGN_TARGET_VIEW ct
          JOIN dim.geodata geo
            ON ct.attribute_value_id = geo.geoid
         WHERE ct.attribute_id = 5
         GROUP BY ct.campaign_id ;;
  }


  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: dma_description {
    type: string
    label: "DMA List"
    description: "Designated Marketing Area"
    sql: ${TABLE}.DMA_DESCRIPTION ;;
  }
}
