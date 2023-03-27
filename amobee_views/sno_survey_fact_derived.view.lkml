view: survey_fact_derived {
  label: "Brandscore Metrics"

  derived_table: {
    sql: SELECT s1.survey_id AS SURVEY_ID
        ,max(sd1.survey_name) AS SURVEY_NAME
        ,s1.survey_answer_id AS ANSWER_ID
        ,max(sd1.answer_text) AS ANSWER_NAME
        ,sd1.question_id AS QUESTION_ID
        ,max(sd1.question_text) AS QUESTION_TEXT
        ,s1.AGE AS AGE_ID
        ,max(av1.DESCRIPTION) AS AGE_DESCRIPTION
        ,s1.GENDER AS GENDER_ID
        ,max(av2.DESCRIPTION) AS GENDER_DESCRIPTION
        ,s1.FLIGHT_MEDIA_ID AS FLIGHT_MEDIA_ID
        ,t.controls_by_question AS CONTROLS_BY_QUESTION
        ,t.exposed_by_question AS EXPOSED_BY_QUESTION
        ,count(s1.adid) AS RESPONSES
        ,sum(CASE WHEN s1.is_exposed = 0 THEN 1 ELSE 0  END) AS CONTROLS
        ,sum(CASE WHEN s1.is_exposed = 1 THEN 1 ELSE 0  END) AS EXPOSED
      FROM demand.SURVEY_FACT s1
      JOIN dim.SURVEY_DETAILS sd1 ON (s1.survey_answer_id = sd1.answer_id AND s1.survey_id = sd1.survey_id)
      JOIN dim.ATTRIBUTE_VALUE av1 ON (s1.AGE = av1.attribute_value_id)
      JOIN dim.ATTRIBUTE_VALUE av2 ON (s1.GENDER = av2.attribute_value_id)
      JOIN (
        SELECT s.survey_id
          ,sd.question_id
          ,sum(CASE WHEN s.is_exposed = 0 THEN 1 ELSE 0 END) AS controls_by_question
          ,sum(CASE WHEN s.is_exposed = 1 THEN 1 ELSE 0 END) AS exposed_by_question
        FROM demand.survey_fact s
        JOIN dim.SURVEY_DETAILS sd ON (s.survey_answer_id = sd.answer_id AND s.survey_id = sd.survey_id)
        GROUP BY 1,2
        ) t ON t.survey_id = s1.survey_id AND t.question_id = sd1.question_id
      GROUP BY s1.survey_id
        ,s1.survey_answer_id
        ,sd1.question_id
        ,s1.AGE
        ,s1.GENDER
        ,s1.FLIGHT_MEDIA_ID
        ,t.controls_by_question
        ,t.exposed_by_question  ;;
  }

  dimension: survey_id {
    type: number
    label: "Survey ID"
    sql: ${TABLE}.SURVEY_ID ;;
    value_format_name: id
  }

  dimension: survey_name {
    type: string
    sql: ${TABLE}.SURVEY_NAME ;;
  }

  dimension: answer_id {
    type: number
    label: "Survey Answer ID"
    sql: ${TABLE}.ANSWER_ID ;;
    value_format_name: id
  }

  dimension: answer_name {
    type: string
    label: "Survey Answer"
    sql: ${TABLE}.ANSWER_NAME ;;
  }

  dimension: question_id {
    type: number
    label: "Survey Question ID"
    sql: ${TABLE}.QUESTION_ID ;;
    value_format_name: id
  }

  dimension: question_text {
    type: string
    label: "Survey Question"
    sql: ${TABLE}.QUESTION_TEXT ;;
  }

  dimension: age_id {
    type: number
    sql: ${TABLE}.AGE_ID ;;
    value_format_name: id
  }

  dimension: age_description {
    type: string
    sql: ${TABLE}.AGE_DESCRIPTION ;;
  }

  dimension: gender_id {
    type: number
    sql: ${TABLE}.GENDER_ID ;;
    value_format_name: id
  }

  dimension: gender_description {
    type: string
    sql: ${TABLE}.GENDER_DESCRIPTION ;;
  }

  dimension: flight_media_id {
    type: number
    #hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
    value_format_name: id
  }

  dimension: total_responses {
    type: number
    hidden: yes
    sql: ${TABLE}.RESPONSES ;;
  }

  measure: sum_responses {
    type: sum
    label: "Total Responses"
    sql: ${total_responses} ;;
  }

  dimension: controls_by_question {
    type: number
    sql: ${TABLE}.CONTROLS_BY_QUESTION ;;
  }

  dimension: exposed_by_question {
    type: number
    sql: ${TABLE}.EXPOSED_BY_QUESTION ;;
  }

  dimension: total_controls {
    type: number
    hidden: yes
    sql: ${TABLE}.CONTROLS ;;
  }

  measure: sum_controls {
    type: sum
    label: "Control Responses"
    sql: ${total_controls} ;;
  }

  dimension: total_exposed {
    type: number
    hidden: yes
    sql: ${TABLE}.EXPOSED ;;
  }

  measure: sum_exposed {
    type: sum
    label: "Exposed Responses"
    sql: ${total_exposed} ;;
  }

}
