view: scale_metric{
  sql_table_name:
    (SELECT keydate,
       cu.country_id,
       omd_by_day.campaign_id,
       omd_by_day.platform_client_id,
       omd_by_day.description,
       Sum(allocation)                         AS allocation,
       Sum(impressions)                        AS impressions,
       Sum(pay_rate * unit_rate * impressions) AS revenue,
       Sum(CASE
             WHEN share_misdelivery < 0
                  AND allocation > 0
                  AND Abs(share_misdelivery) / allocation >= 0.2 THEN Abs(
             pay_rate * unit_rate * share_misdelivery)
             ELSE 0
           END)                                AS over_allocation,
       Sum(CASE
             WHEN share_misdelivery < 0
                  AND Abs(share_misdelivery) / allocation >= 0.2
                  AND share_misdelivery1 < 0
                  AND allocation1 > 0
                  AND Abs(share_misdelivery1) / allocation1 >= 0.2
                  AND share_misdelivery2 < 0
                  AND allocation2 > 0
                  AND Abs(share_misdelivery2) / allocation2 >= 0.2 THEN Abs(
             pay_rate * unit_rate * share_misdelivery)
             ELSE 0
           END)                                AS over_allocation_consecutive,
       Sum(CASE
             WHEN share_misdelivery > 0
                  AND allocation > 0
                  AND Abs(share_misdelivery) / allocation >= 0.2 THEN Abs(
             pay_rate * unit_rate * share_misdelivery)
             ELSE 0
           END)                                AS under_allocation,
       Sum(CASE
             WHEN share_misdelivery > 0
                  AND Abs(share_misdelivery) / allocation >= 0.2
                  AND share_misdelivery1 > 0
                  AND allocation1 > 0
                  AND Abs(share_misdelivery1) / allocation1 >= 0.2
                  AND share_misdelivery2 > 0
                  AND allocation2 > 0
                  AND Abs(share_misdelivery2) / allocation2 >= 0.2 THEN Abs(
             pay_rate * unit_rate * share_misdelivery)
             ELSE 0
           END)                                AS under_allocation_consecutive
FROM   (SELECT a.keydate,
               a.description,
               a.platform_client_id,
               a.campaign_id,
               a.allocation,
               a.impressions,
               a.share_misdelivery,
               COALESCE(a1.share_misdelivery, 0) AS share_misdelivery1,
               COALESCE(a2.share_misdelivery, 0) AS share_misdelivery2,
               a.pay_rate,
               a.unit_rate,
               COALESCE(a1.allocation, 0)        AS allocation1,
               COALESCE(a2.allocation, 0)        AS allocation2,
               a.day_id
        FROM   (SELECT keydate,
                       pc.description,
                       pc.platform_client_id,
                       a.campaign_id,
                       Sum(mean_allocation)                    AS allocation,
                       Sum(impressions)                        AS impressions,
                       Sum(share_md)                           AS
                       share_misdelivery,
                       Sum(actual_units) / Sum(impressions)    AS unit_rate,
                       Max(CASE
                             WHEN cpu_type_id = 1 THEN 1.00 * ca.cpu / 1000
                             ELSE ca.cpu
                           END)                                AS pay_rate,
                       Datediff(dd, b.begin_datetm, a.keydate) AS day_id
                FROM   an_research..opt_misdelivery (nolock) a
                       JOIN an_main..flight (nolock) b
                         ON a.flight_id = b.flight_id
                            AND a.keydate >= b.begin_datetm
                            AND a.keydate < CONVERT(DATE, Getdate())
                       JOIN an_main..campaign ca (nolock)
                         ON ca.campaign_id = a.campaign_id
                       JOIN an_main..platform_client pc (nolock)
                         ON pc.platform_client_id = ca.platform_client_id
                WHERE  {% condition platform_client_id %} pc.platform_client_id {% endcondition %}
                GROUP  BY keydate,
                          pc.description,
                          pc.platform_client_id,
                          a.campaign_id,
                          Datediff(dd, b.begin_datetm, a.keydate)
                HAVING Sum(impressions) > 0
                       AND Sum(mean_allocation) > 1000) AS a
               LEFT JOIN (SELECT keydate,
                                 a.campaign_id,
                                 pc.description,
                                 pc.platform_client_id,
                                 Sum(mean_allocation)                    AS
                                 allocation,
                                 Sum(impressions)                        AS
                                 impressions
                                 ,
                                 Sum(share_md)
                                 AS share_misdelivery,
                                 Sum(actual_units) / Sum(impressions)    AS
                                 unit_rate,
                                 Max(CASE
                                       WHEN cpu_type_id = 1 THEN
                                       1.00 * ca.cpu / 1000
                                       ELSE ca.cpu
                                     END)                                AS
                                 pay_rate,
                                 Datediff(dd, b.begin_datetm, a.keydate) AS
                                 day_id
                          FROM   an_research..opt_misdelivery (nolock) a
                                 JOIN an_main..flight (nolock) b
                                   ON a.flight_id = b.flight_id
                                      AND a.keydate >= b.begin_datetm
                                      AND a.keydate < CONVERT(DATE, Getdate())
                                 JOIN an_main..campaign ca (nolock)
                                   ON ca.campaign_id = a.campaign_id
                                 JOIN an_main..platform_client pc (nolock)
                                   ON pc.platform_client_id =
                                      ca.platform_client_id
                          WHERE  {% condition platform_client_id %} pc.platform_client_id {% endcondition %}
                          GROUP  BY keydate,
                                    pc.description,
                                    pc.platform_client_id,
                                    a.campaign_id,
                                    Datediff(dd, b.begin_datetm, a.keydate)
                          HAVING Sum(impressions) > 0
                                 AND Sum(mean_allocation) > 1000) a1
                      ON a1.campaign_id = a.campaign_id
                         AND a1.keydate = Dateadd(dd, -1, a.keydate)
               LEFT JOIN (SELECT keydate,
                                 pc.description,
                                 pc.platform_client_id,
                                 a.campaign_id,
                                 Sum(mean_allocation)                    AS
                                 allocation,
                                 Sum(impressions)                        AS
                                 impressions
                                 ,
                                 Sum(share_md)
                                 AS share_misdelivery,
                                 Sum(actual_units) / Sum(impressions)    AS
                                 unit_rate,
                                 Max(CASE
                                       WHEN cpu_type_id = 1 THEN
                                       1.00 * ca.cpu / 1000
                                       ELSE ca.cpu
                                     END)                                AS
                                 pay_rate,
                                 Datediff(dd, b.begin_datetm, a.keydate) AS
                                 day_id
                          FROM   an_research..opt_misdelivery (nolock) a
                                 JOIN an_main..flight (nolock) b
                                   ON a.flight_id = b.flight_id
                                      AND a.keydate >= b.begin_datetm
                                      AND a.keydate < CONVERT(DATE, Getdate())
                                 JOIN an_main..campaign ca (nolock)
                                   ON ca.campaign_id = a.campaign_id
                                 JOIN an_main..platform_client pc (nolock)
                                   ON pc.platform_client_id =
                                      ca.platform_client_id
                          WHERE {% condition platform_client_id %} pc.platform_client_id {% endcondition %}
                          GROUP  BY keydate,
                                    pc.description,
                                    pc.platform_client_id,
                                    a.campaign_id,
                                    Datediff(dd, b.begin_datetm, a.keydate)
                          HAVING Sum(impressions) > 0
                                 AND Sum(mean_allocation) > 1000) a2
                      ON a2.campaign_id = a.campaign_id
                         AND a2.keydate = Dateadd(dd, -2, a.keydate)) AS
       omd_by_day
JOIN an_main..campaign cid (nolock)
ON   cid.campaign_id = omd_by_day.campaign_id
JOIN an_main..customer cu (nolock)
ON cu.customer_id = cid.customer_id
GROUP  BY keydate,
          cu.country_id,
          omd_by_day.platform_client_id,
          omd_by_day.description,
          omd_by_day.campaign_id
)
       ;;

  dimension: platform_client_id {
    type: number
    description: "Some common IDs: GroupM UK (5), GroupM UK 2 (278), GroupM UK 3 (449), GroupM UK 4 (766), GroupM UK 5 (793), Xaxis UK (86) "
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension:  month{
    type: number
    value_format_name: id
    sql: datepart(month,${TABLE}.keydate) as month;;
    hidden: yes
  }


  dimension:  keydate{
    primary_key: yes
    type: date
    sql: ${TABLE}.keydate;;
    hidden: yes
  }

  dimension_group: utc_date {
    type: time
    label: "Scale Metric "
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "Date to be used for pulling scale metric data"
    sql: ${TABLE}.keydate ;;
  }

  dimension: description {
    type: string
    label: "Platform Client Name"
    sql: ${TABLE}.description ;;
  }

  measure: allocation {
    type: sum
    label: "Allocation"
    value_format_name: decimal_0
    description: "Allocated Impressions"
    sql: ${TABLE}.allocation ;;
  }

  measure: impressions {
    type: sum
    label: "Impressions"
    value_format_name: decimal_0
    description: ""
    sql: ${TABLE}.impressions ;;
  }

  measure: revenue {
    type: sum
    label: "Revenue"
    value_format_name: gbp
    sql: ${TABLE}.revenue;;
  }

  measure: over_allocation {
    type: sum
    label: "Over Allocation"
    value_format_name: gbp
    sql: ${TABLE}.over_allocation ;;
  }

  measure: over_allocation_consecutive {
    type: sum
    label: "Over Allocation Consecutive"
    value_format_name: gbp
    sql: ${TABLE}.over_allocation_consecutive ;;
  }

  measure: under_allocation {
    type:  sum
    label: "Under Allocation"
    value_format_name: gbp
    sql: ${TABLE}.under_allocation ;;
  }

  measure: under_allocation_consecutive {
    type: sum
    label: "Under Allocation Consecutive"
    value_format_name: gbp
    sql: ${TABLE}.under_allocation_consecutive;;
  }


  set: detail {
    fields: [
      allocation,
      impressions,
      revenue,
      over_allocation,
      over_allocation_consecutive,
      under_allocation,
      under_allocation_consecutive
    ]
  }

}
