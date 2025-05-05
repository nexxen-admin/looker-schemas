view: snapshot_quarterly_forecast {
  sql_table_name: BI_DSP.Snapshot_Quarterly_Forecast ;;

  dimension: account_manager {
    type: string
    sql: ${TABLE}."account manager" ;;
  }
  dimension: account_manager_2 {
    type: string
    sql: ${TABLE}."account manager 2" ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}."deal type" ;;
  }
  dimension: generalist_rep {
    type: string
    sql: ${TABLE}."generalist rep" ;;
  }
  dimension: holding_company {
    type: string
    sql: ${TABLE}."holding company" ;;
  }
  dimension: io_group_name {
    type: string
    sql: ${TABLE}."io group name" ;;
  }
  dimension: io_region {
    type: string
    sql: ${TABLE}."io region" ;;
  }
  dimension: io_super_region {
    type: string
    sql: ${TABLE}."io super region" ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}."io type" ;;
  }
  dimension: net_revenue_booked {
    type: number
    sql: ${TABLE}."net revenue booked" ;;
  }
  dimension: net_revenue_forecast {
    type: number
    sql: ${TABLE}."net revenue forecast" ;;
  }
  dimension: opp_or_order_id {
    type: string
    sql: ${TABLE}."opp or order id" ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}."opportunity owner" ;;
  }

  # dimension: strat_sales_team {
  #   type: string
  #   label: "Strat Sales Team"
  #   sql:
  #   CASE
  #     -- Strat Sales - East
  #     WHEN ${TABLE}.opportunity_owner = 'Andrea St. Pierre' THEN 'Strat Sales - East'

  #     -- Strat Sales - East 4
  #     WHEN ${TABLE}.opportunity_owner IN ('Abbe Simmons', 'Adam Wince', 'Alex Miller', 'Gena Grossberg', 'John Bohlinger') THEN 'Strat Sales - East 4'

  #     -- Strat Sales - East 6
  #     WHEN ${TABLE}.opportunity_owner IN ('Brian Cincotta', 'Dominic Venuti', 'Mike Ternullo') THEN 'Strat Sales - East 6'

  #     -- Strat Sales - East 3
  #     WHEN ${TABLE}.opportunity_owner IN ('Ben Miller', 'Emily Brown', 'Kate Schoenfeld') THEN 'Strat Sales - East 3'

  #     -- Strat Sales - East 1
  #     WHEN ${TABLE}.opportunity_owner IN ('Amanda Pietruszka', 'Kelly Jahrnes', 'Mike Connon', 'Ray Conboy - Backfill', 'Taylor Kiefer', 'Stephen Jensen', 'Zachary Tamuzza') THEN 'Strat Sales - East 1'

  #     -- Strat Sales - East 5
  #     WHEN ${TABLE}.opportunity_owner IN ('Ryan Ammerman', 'Todd Goldberg') THEN 'Strat Sales - East 5'

  #     -- Strat Sales - East 2
  #     WHEN ${TABLE}.opportunity_owner IN ('Carolina Rivera', 'Mollie Darby', 'Sara Rethinger', 'Sydney Long') THEN 'Strat Sales - East 2'

  #     -- Strat Sales - Central
  #     WHEN ${TABLE}.opportunity_owner = 'Jeff Zito' THEN 'Strat Sales - Central'

  #     -- Strat Sales - Central 1
  #     WHEN ${TABLE}.opportunity_owner IN (
  #     'Collin Korab', 'Claire Riley', 'Jason Ciesiolka', 'Jennifer McCallum',
  #     'Kate Shepard', 'Katie Reisinger', 'Sara Ingold', 'Stuart Prentice',
  #     'Jeffrey Budnick', 'Ryan Kraft', 'Erin Frey', 'Jared Hinkel',
  #     'Jennifer Embler', 'Mitch Hubbarth', 'Wade Baxter'
  #     ) THEN 'Strat Sales - Central 1'

  #     -- Strat Sales - Central 2
  #     WHEN ${TABLE}.opportunity_owner IN (
  #     'Denise Janowski', 'Lindsey Dobbs', 'Ben Fichtenbaum', 'Madison Holcomb',
  #     'Dan Hammond', 'Haley Thompson', 'Brandon Bailey', 'Dan Thornton',
  #     'Glenn Sims', 'New Hire 1 - Central'
  #     ) THEN 'Strat Sales - Central 2'

  #     -- Strat Sales - Central 3
  #     WHEN ${TABLE}.opportunity_owner IN ('Adnan Khan', 'Mark Kates', 'Nick Catley', 'Sania Haider') THEN 'Strat Sales - Central 3'

  #     -- Strat Sales - West
  #     WHEN ${TABLE}.opportunity_owner = 'Sarineh Croft' THEN 'Strat Sales - West'

  #     -- Strat Sales - West 1
  #     WHEN ${TABLE}.opportunity_owner IN (
  #     'Abe Chami', 'Kent Nguyen', 'Nicole Richlak', 'Stephanie Haina',
  #     'Andrew Leary', 'Conner Johnson', 'Laura Grifka', 'Lauren Wiest',
  #     'Nina Ganelin', 'Tim Berman', 'Danielle Wolf - Kent'
  #     ) THEN 'Strat Sales - West 1'

  #     -- Strat Sales - West 2
  #     WHEN ${TABLE}.opportunity_owner IN (
  #     'Andrew Scharkss', 'Danielle Bracamonte', 'Joe Ambrosio', 'Jonathan Chiang',
  #     'Lauren Burns', 'Mark Haddow'
  #     ) THEN 'Strat Sales - West 2'

  #     -- Special case
  #     WHEN ${TABLE}.opportunity_owner = 'Danielle Wolf' THEN 'daniellewolf'

  #     ELSE NULL
  #     END ;;
  # }


  dimension: related_brand {
    type: string
    sql: ${TABLE}."related brand" ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}."schedule converted revenue v2" ;;
  }
  dimension: scheduled_net_revenue_v2 {
    type: number
    sql: ${TABLE}."scheduled net revenue v2" ;;
  }
  dimension: social_specialist {
    type: string
    sql: ${TABLE}."social specialist" ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension_group: today {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.today ;;
  }
  dimension: tv_specialist {
    type: string
    sql: ${TABLE}."tv specialist" ;;
  }
  measure: count {
    type: count
    drill_fields: [io_group_name]
  }
}
