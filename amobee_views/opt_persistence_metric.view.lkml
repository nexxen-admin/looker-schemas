view: misallocation_persistence{
  sql_table_name:
  (SELECT Sum(total_days)                     AS total_days,
       campaign_id,
       platform_client_id,
       description,
       Min(begin_datetm)                   AS begin_date,
       Max(end_datetm)                     AS end_date,
       Avg(num_days_overallocated)         AS num_days_overallocated,
       Avg(num_days_underallocated)        AS num_days_underallocated,
       Avg(revenue)                        AS revenue,
       month,
       Avg(num_days_overallocated_consec)  AS num_days_overallocated_consec,
       Avg(num_days_underallocated_consec) AS num_days_underallocated_consec
FROM   (SELECT Datepart(month, keydate)                                    AS
               month,
               flight_id,
               begin_datetm,
               end_datetm,
               platform_client_id,
               persistance.description,
               persistance.campaign_id,
               Sum(persistance.revenue)                                    AS
               revenue,
               Sum(CASE
                     WHEN over_allocation > 0 THEN 1
                     ELSE 0
                   END)                                                    AS
                      num_days_overallocated,
               Sum(CASE
                     WHEN under_allocation > 0 THEN 1
                     ELSE 0
                   END)                                                    AS
                      num_days_underallocated,
               Sum(CASE
                     WHEN over_allocation_consecutive > 0 THEN 1
                     ELSE 0
                   END)                                                    AS
                      num_days_overallocated_consec,
               Sum(CASE
                     WHEN under_allocation_consecutive > 0 THEN 1
                     ELSE 0
                   END)                                                    AS
                      num_days_underallocated_consec,
               Abs (Datediff(day, Max(c.end_datetm), Min(c.begin_datetm))) AS
                      total_days
        FROM   (SELECT keydate,
                       description,
                       platform_client_id,
                       campaign_id,
                       day_id,
                       Sum(allocation)                         AS allocation,
                       Sum(impressions)                        AS impressions,
                       Sum(pay_rate * unit_rate * impressions) AS revenue,
                       Sum(CASE
                             WHEN share_misdelivery < 0
                                  AND allocation > 0
                                  AND Abs(share_misdelivery) / allocation >= 0.2
                           THEN
                             Abs(
                             pay_rate * unit_rate * share_misdelivery)
                             ELSE 0
                           END)                                AS
                       over_allocation,
                       Sum(CASE
                             WHEN share_misdelivery < 0
                                  AND Abs(share_misdelivery) / allocation >= 0.2
                                  AND share_misdelivery1 < 0
                                  AND allocation1 > 0
                                  AND Abs(share_misdelivery1) / allocation1 >=
                                      0.2
                                  AND share_misdelivery2 < 0
                                  AND allocation2 > 0
                                  AND Abs(share_misdelivery2) / allocation2 >=
                                      0.2 THEN
                             Abs(
                             pay_rate * unit_rate * share_misdelivery)
                             ELSE 0
                           END)                                AS
                       over_allocation_consecutive,
                       Sum(CASE
                             WHEN share_misdelivery > 0
                                  AND allocation > 0
                                  AND Abs(share_misdelivery) / allocation >= 0.2
                           THEN
                             Abs(
                             pay_rate * unit_rate * share_misdelivery)
                             ELSE 0
                           END)                                AS
                       under_allocation,
                       Sum(CASE
                             WHEN share_misdelivery > 0
                                  AND Abs(share_misdelivery) / allocation >= 0.2
                                  AND share_misdelivery1 > 0
                                  AND allocation1 > 0
                                  AND Abs(share_misdelivery1) / allocation1 >=
                                      0.2
                                  AND share_misdelivery2 > 0
                                  AND allocation2 > 0
                                  AND Abs(share_misdelivery2) / allocation2 >=
                                      0.2 THEN
                             Abs(
                             pay_rate * unit_rate * share_misdelivery)
                             ELSE 0
                           END)                                AS
                       under_allocation_consecutive
                FROM   (SELECT a.keydate,
                               a.description,
                               a.platform_client_id,
                               a.campaign_id,
                               a.allocation,
                               a.impressions,
                               a.share_misdelivery,
                               COALESCE(a1.share_misdelivery, 0) AS
                               share_misdelivery1,
                               COALESCE(a2.share_misdelivery, 0) AS
                               share_misdelivery2,
                               a.pay_rate,
                               a.unit_rate,
                               COALESCE(a1.allocation, 0)        AS allocation1,
                               COALESCE(a2.allocation, 0)        AS allocation2,
                               a.day_id
                        FROM   (SELECT keydate,
                                       pc.description,
                                       pc.platform_client_id,
                                       a.campaign_id,
                                       Sum(mean_allocation)
                                       AS
                                       allocation,
                                       Sum(impressions)
                                       AS
                                       impressions,
                                       Sum(share_md)
                                       AS
                                       share_misdelivery,
                                       Sum(actual_units) / Sum(impressions)
                                       AS
                                       unit_rate,
                                       Max(CASE
                                             WHEN cpu_type_id = 1 THEN
                                             1.00 * ca.cpu / 1000
                                             ELSE ca.cpu
                                           END)
                                       AS
                                       pay_rate,
                                       Datediff(dd, b.begin_datetm, a.keydate)
                                       AS
                                       day_id
                                FROM   an_research..opt_misdelivery (nolock) a
                                       JOIN an_main..flight (nolock) b
                                         ON a.flight_id = b.flight_id
                                            AND a.keydate >= b.begin_datetm
                                            AND a.keydate < CONVERT(DATE,
                                                            Getdate())
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
                                          Datediff(dd, b.begin_datetm,
                               a.keydate)
                                HAVING Sum(impressions) > 0
                                       AND Sum(mean_allocation) > 1000) AS a
                               LEFT JOIN (SELECT keydate,
                                                 pc.description,
                                                 pc.platform_client_id,
                                                 a.campaign_id,
                                                 Sum(mean_allocation)
                                                 AS
                                                 allocation,
                                                 Sum(impressions)
                                                 AS
                                                 impressions
                                                 ,
                                                 Sum(share_md)
                                                 AS share_misdelivery,
                                                 Sum(actual_units) / Sum(
                                                 impressions)
                                                 AS
                                                 unit_rate,
                                                 Max(CASE
                                                       WHEN cpu_type_id = 1 THEN
                                                       1.00 * ca.cpu / 1000
                                                       ELSE ca.cpu
                                                     END)
                                                 AS
                                                 pay_rate,
                                                 Datediff(dd, b.begin_datetm,
                                                 a.keydate) AS
                                                 day_id
                                          FROM   an_research..opt_misdelivery (
                                                 nolock)
                                                 a
                                                 JOIN an_main..flight (nolock) b
                                                   ON a.flight_id = b.flight_id
                                                      AND
                                         a.keydate >= b.begin_datetm
                                                      AND a.keydate < CONVERT(
                                                          DATE,
                                                                      Getdate())
                                                 JOIN an_main..campaign ca (
                                                      nolock)
                                                   ON ca.campaign_id =
                                                      a.campaign_id
                                                 JOIN an_main..platform_client
                                                      pc (
                                                      nolock)
                                                   ON pc.platform_client_id =
                                                      ca.platform_client_id
                                          WHERE  {% condition platform_client_id %} pc.platform_client_id {% endcondition %}
                                          GROUP  BY keydate,
                                                    pc.description,
                                                    pc.platform_client_id,
                                                    a.campaign_id,
                                                    Datediff(dd, b.begin_datetm,
                                                    a.keydate)
                                          HAVING Sum(impressions) > 0
                                                 AND Sum(mean_allocation) > 1000
                                         ) a1
                                      ON a1.campaign_id = a.campaign_id
                                         AND a1.keydate = Dateadd(dd, -1,
                                                          a.keydate)
                               LEFT JOIN (SELECT keydate,
                                                 pc.description,
                                                 pc.platform_client_id,
                                                 a.campaign_id,
                                                 Sum(mean_allocation)
                                                 AS
                                                 allocation,
                                                 Sum(impressions)
                                                 AS
                                                 impressions
                                                 ,
                                                 Sum(share_md)
                                                 AS share_misdelivery,
                                                 Sum(actual_units) / Sum(
                                                 impressions)
                                                 AS
                                                 unit_rate,
                                                 Max(CASE
                                                       WHEN cpu_type_id = 1 THEN
                                                       1.00 * ca.cpu / 1000
                                                       ELSE ca.cpu
                                                     END)
                                                 AS
                                                 pay_rate,
                                                 Datediff(dd, b.begin_datetm,
                                                 a.keydate) AS
                                                 day_id
                                          FROM   an_research..opt_misdelivery (
                                                 nolock)
                                                 a
                                                 JOIN an_main..flight (nolock) b
                                                   ON a.flight_id = b.flight_id
                                                      AND
                                         a.keydate >= b.begin_datetm
                                                      AND a.keydate < CONVERT(
                                                          DATE,
                                                                      Getdate())
                                                 JOIN an_main..campaign ca (
                                                      nolock)
                                                   ON ca.campaign_id =
                                                      a.campaign_id
                                                 JOIN an_main..platform_client
                                                      pc (
                                                      nolock)
                                                   ON pc.platform_client_id =
                                                      ca.platform_client_id
                                          WHERE  {% condition platform_client_id %} pc.platform_client_id {% endcondition %}
                                          GROUP  BY keydate,
                                                    pc.description,
                                                    pc.platform_client_id,
                                                    a.campaign_id,
                                                    Datediff(dd, b.begin_datetm,
                                                    a.keydate)
                                          HAVING Sum(impressions) > 0
                                                 AND Sum(mean_allocation) > 1000
                                         ) a2
                                      ON a2.campaign_id = a.campaign_id
                                         AND a2.keydate = Dateadd(dd, -2,
                                                          a.keydate))
                       AS
                       omd_by_day
                GROUP  BY keydate,
                          description,
                          platform_client_id,
                          campaign_id,
                          day_id) AS persistance
               JOIN an_main..flight c (nolock)
                 ON c.campaign_id = persistance.campaign_id
        WHERE  c.active = 1
        GROUP  BY Datepart(month, keydate),
                  persistance.campaign_id,
                  flight_id,
                  begin_datetm,
                  end_datetm,
                  platform_client_id,
                  persistance.description) AS persistance_complete
GROUP  BY campaign_id,
          month,
          description,
          platform_client_id
     )                         ;;


  dimension:  month{
    type: number
    value_format_name: id
    sql: ${TABLE}.month;;
  }

  filter: platform_client_id {
    type: number
    description: "Some common IDs: GroupM UK (5), GroupM UK 2 (278), GroupM UK 3 (449), GroupM UK 4 (766), GroupM UK 5 (793), Xaxis UK (86) "
  }

  dimension: description {
    type: string
    label: "Platform Client Name"
    sql: ${TABLE}.description ;;
  }

  dimension: campaign_id {
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.campaign_id ;;
  }

  measure: num_days_overallocated {
    type: average
    label: "Number of days overallocated"
    sql: (${TABLE}.num_days_overallocated);;
  }

  measure: num_days_underallocated {
    type: average
    label: "Number of days underallocated"
    sql: (${TABLE}.num_days_underallocated);;
  }

  measure: revenue {
    type: average
    label: "Revenue"
    value_format_name: gbp
    sql: (${TABLE}.revenue);;
  }

  measure: num_days_overallocated_consec {
    type: average
    label: "Number of day overallocated consecutive"
    sql: (${TABLE}.num_days_overallocated_consec);;
  }

  measure: num_days_underallocated_consec {
    type: average
    label: "Number of day underallocated consecutive"
    sql: (${TABLE}.num_days_underallocated_consec);;
  }

  measure: total_days {
    type: average
    label: "Total Days"
    description: "Total days a campaign ran for"
    sql: (${TABLE}.total_days);;
  }

}
