view: fce_atv_fdp_data_attr {
  label: "Pool Attributes"
  derived_table: {
    sql:
      select
        p.*
      from
      (
        select
          t.pool_id,
          t.attr,
          listagg(t.value, '|') within group (order by t.value) as value
        from
        (
          select distinct
            data.data_vals:pool_id as pool_id,
            data.data_vals:key as attr,
            data.data_vals:value as value
          from fce_atv_fdp_data.info info
            join fce_atv_fdp_data.data data on info.iid = data.iid
          where info.kind = 'RAW_FEATURE'
            and info.name = 'pool_properties'
            and data.data_vals:property = 'attributes'
        ) as t
        group by
          t.pool_id,
          t.attr
      ) as t2
      pivot(max(t2.value) for t2.attr in ('ACTOR', 'ADJUDICATOR', 'BUY_TYPE', 'CHEF', 'COMMENTATOR', 'DIRECTOR', 'EPISODE', 'GENRE', 'GUEST', 'HOST', 'INTEGRATION_TYPE', 'INTERVIEWER', 'JUDGE', 'MEDIALIST', 'PANELLIST', 'PLACEMENT_ID', 'PLACEMENT_QUALITY', 'PRESENTER', 'PROGRAM', 'PUBLISHER_ID', 'SELLING_TITLE', 'SERIES', 'SINGER', 'SPECIAL_GUEST', 'SUBGENRE', 'SUPPLY_DEVICE_TYPE', 'SUPPLY_FORMAT_TYPE', 'SUPPLY_PLATFORM_CLIENT_ID', 'TALENT'))
      as p (pool_id, actor, adjudicator, buy_type, chef, commentator, director, episode, genre, guest, host, integration_type, interviewer, judge, medialist, panellist, placement_id, placement_quality, presenter, program, publisher_id, selling_title, series, singer, special_guest, subgenre, supply_device_type, supply_format_type, supply_platform_client_id, talent) ;;
  }
  suggestions: no

  dimension: pool_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pool_id::varchar ;;
  }

  dimension: actor {
    type: string
    label: "Actor"
    sql: ${TABLE}.actor ;;
  }

  dimension: adjudicator {
    type: string
    label: "Adjudicator"
    sql: ${TABLE}.adjudicator ;;
  }

  dimension: buy_type {
    type: string
    label: "Buy Type"
    sql: ${TABLE}.buy_type ;;
  }

  dimension: chef {
    type: string
    label: "Chef"
    sql: ${TABLE}.chef ;;
  }

  dimension: commentator {
    type: string
    label: "Commentator"
    sql: ${TABLE}.commentator ;;
  }

  dimension: director {
    type: string
    label: "Director"
    sql: ${TABLE}.director ;;
  }

  dimension: episode {
    type: string
    label: "Episode"
    sql: ${TABLE}.episode ;;
  }

  dimension: genre {
    type: string
    label: "Genre"
    sql: ${TABLE}.genre ;;
  }

  dimension: guest {
    type: string
    label: "Guest"
    sql: ${TABLE}.guest ;;
  }

  dimension: host {
    type: string
    label: "Host"
    sql: ${TABLE}.host ;;
  }

  dimension: integration_type {
    type: string
    label: "Integration Type"
    sql: ${TABLE}.integration_type ;;
  }

  dimension: interviewer {
    type: string
    label: "Interviewer"
    sql: ${TABLE}.interviewer ;;
  }

  dimension: judge {
    type: string
    label: "Judge"
    sql: ${TABLE}.judge ;;
  }

  dimension: medialist {
    type: string
    label: "Media List"
    sql: ${TABLE}.medialist ;;
  }

  dimension: panellist {
    type: string
    label: "Panel List"
    sql: ${TABLE}.panellist ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    value_format_name: id
    sql: ${TABLE}.placement_id::int ;;
  }

  dimension: placement_quality {
    type: string
    label: "Placement Quality"
    sql: ${TABLE}.placement_quality ;;
  }

  dimension: presenter {
    type: string
    label: "Presenter"
    sql: ${TABLE}.presenter ;;
  }

  dimension: program {
    type: string
    label: "Program"
    sql: ${TABLE}.program ;;
  }

  dimension: publisher_id {
    type: string
    # type: number
    label: "Publisher ID"
    value_format_name: id
    # sql: ${TABLE}.publisher_id::int ;;
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: selling_title {
    type: string
    label: "Selling Title"
    sql: ${TABLE}.selling_title ;;
  }

  dimension: series {
    type: string
    label: "Series"
    sql: ${TABLE}.series ;;
  }

  dimension: singer {
    type: string
    label: "Singer"
    sql: ${TABLE}.singer ;;
  }

  dimension: special_guest {
    type: string
    label: "Special Guest"
    sql: ${TABLE}.special_guest ;;
  }

  dimension: subgenre {
    type: string
    label: "Subgenre"
    sql: ${TABLE}.subgenre ;;
  }

  dimension: supply_device_type {
    type: string
    label: "Supply Device Type"
    sql: ${TABLE}.supply_device_type ;;
  }

  dimension: supply_format_type {
    type: string
    label: "Supply Format Type"
    sql: ${TABLE}.supply_format_type ;;
  }

  dimension: supply_platform_client_id {
    type: number
    label: "Supply Platform Client ID"
    value_format_name: id
    sql: ${TABLE}.supply_platform_client_id::int ;;
  }

  dimension: talent {
    type: string
    label: "Talent"
    sql: ${TABLE}.talent ;;
  }
}
