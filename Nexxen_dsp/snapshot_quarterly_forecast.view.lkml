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

  dimension: enterprise_sales_team {
    type: string
    label: "Enterprise Sales Team"
    sql:
    CASE
      WHEN ${generalist_rep} = 'ITV' THEN 'ITV'

      -- Enterprise Sales House Accounts
      WHEN ${generalist_rep} IN ('Chance Johnson', 'Kara Puccinelli') THEN 'Enterprise Sales House Accounts'

      -- Political
      WHEN ${generalist_rep} IN ('Kory Vargas Caro', 'Tonia Robinson', 'Alexander C. Johnson', 'Alex Johnson') THEN 'Political'

      -- Central
      WHEN ${generalist_rep} IN (
      'Stu Girgins', 'Seth Meyerowitz', 'Laurie Hartnett', 'Amanda Krueger',
      'Michael Lewis', 'TBD Central Seller 1', 'TBD Central Seller 2',
      'Steven M. Sackey', 'Steven Sackey'
      ) THEN 'Central'

      -- East
      WHEN ${generalist_rep} IN (
      'Ariel Deitz', 'Trevor Vincent', 'Stacey Greco', 'Tice Mays',
      'Nikki Gastler', 'TBH  - East 1'
      ) THEN 'East'

      -- West
      WHEN ${generalist_rep} IN (
      'Melodey Sepsey', 'Amber Iwanski', 'Nicole Eisenberg',
      'TBH - West 1', 'TBD West Seller 1', 'Anne Williams',
      'Matt Brown (Sales - LA)'
      ) THEN 'West'

      -- Linear TV (Maloy)
      WHEN ${generalist_rep} IN (
      'Vincent McCarthy', 'Stuart Smilowitz', 'Kevin M. Maloy'
      ) THEN 'Linear TV (Maloy)'

      -- Enterprise - PMP
      WHEN ${generalist_rep} = 'Andrea Schneider' THEN 'Enterprise - PMP'

      ELSE NULL
      END ;;
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

  dimension: revenue_line_v2 {
    type: string
    label: "Revenue Line v2"
    sql:
    CASE
    WHEN ${io_type} = 'All - Market Expectation' THEN 'All - Market Expectation'

      WHEN ${io_type} = 'Non-Media Reports, Services' THEN 'Non-Media Reports, Services'

      WHEN ${io_type} ILIKE '%Amobee TV%' THEN 'TV'
      WHEN ${io_type} ILIKE '%TV Supply%' THEN 'TV'
      WHEN ${io_type} ILIKE '%TV Demand%' THEN 'TV'
      WHEN ${io_type} ILIKE '%TV%' THEN 'TV'

      WHEN ${io_type} = 'Media Managed' THEN 'MS'
      WHEN ${io_type} ILIKE '%Media%' THEN 'MS'

      WHEN ${io_type} IN ('Platform Managed', 'Platform ATD', 'Platform MSP', 'Platform HOK', 'Platform') THEN 'DSP (Self-Service & Managed)'

      WHEN ${io_type} IN ('Social Managed', 'Social ATD', 'Social MSP', 'Social HOK') THEN 'Social'

      WHEN ${io_type} IN ('PMP', 'OMP') THEN 'PMP'

      ELSE 'Missing'
    END ;;
}


  #     WHEN ${io_type} = 'All - Market Expectation' THEN 'All - Market Expectation'

  #     WHEN ${io_type} IN (
  #     'Amobee TV Media Managed',
  #     'Amobee TV Platform Managed',
  #     'Amobee TV Platform HOK',
  #     'Amobee TV Platform ATD',
  #     'Amobee TV',
  #     'TV Supply',
  #     'TV',
  #     'TV Demand - Media Managed',
  #     'TV Demand - Platform Managed',
  #     'TV Demand - HOK'
  #     ) THEN 'TV'

  #     WHEN ${io_type} = 'Media Managed' THEN 'MS'

  #     WHEN ${io_type} = 'Platform Managed' THEN 'DSP (Self-Service & Managed)'

  #     WHEN ${io_type} LIKE '%Media%' THEN 'MS'
  #     WHEN ${io_type} LIKE '%MS%' THEN 'MS'

  #     WHEN ${io_type} IN ('Platform ATD', 'Platform MSP', 'Platform HOK', 'SS') THEN 'DSP (Self-Service & Managed)'

  #     WHEN ${io_type} LIKE '%Platform%' THEN 'DSP (Self-Service & Managed)'

  #     WHEN ${io_type} IN ('Social Managed', 'Social ATD', 'Social MSP', 'Social HOK') THEN 'Social'
  #     WHEN ${io_type} LIKE '%Social%' THEN 'Social'

  #     WHEN ${io_type} LIKE '%PMP%' THEN 'PMP'

  #     ELSE NULL
  #     END ;;
  # }

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

 dimension: strat_sales_team {

  type: string
  label: "Strat Sales Team"
  sql:
  CASE
      -- Strat Sales - Canada
      WHEN ${opportunity_owner} IN ('Sania Haider', 'Adnan Khan', 'Sunny Singh', 'Mark Kates') THEN 'Strat Sales - Canada'

      -- Strat Sales - Budnick
      WHEN ${opportunity_owner} IN ('Jeffrey Budnick', 'Ryan Kraft') THEN 'Strat Sales - Budnick'

      -- Strat Sales - Central
      WHEN ${opportunity_owner} = 'TBH VP Central' THEN 'Strat Sales - Central'

      -- Strat Sales - Ciesiolka
      WHEN ${opportunity_owner} IN ('Jason Ciesiolka', 'Sara Ingold', 'Jennifer McCallum', 'Katie Reisinger', 'Samantha Hosler', 'Anthony McLaughlin', 'Claire Riley') THEN 'Strat Sales - Ciesiolka'

      -- Strat Sales - Feder
      WHEN ${opportunity_owner} IN ('Allison Feder', 'Kaitlyn Dimler', 'Erin Frey', 'Sally Bloom', 'Strat Sales - Feder') THEN 'Strat Sales - Feder'

      -- Strat Sales - Hubbarth
      WHEN ${opportunity_owner} IN ('Mitch Hubbarth', 'Wade Baxter', 'Alec Enfield', 'Jared Hinkel', 'Stuart Prentice', 'Richard Zeilhofer', 'Strat Sales - Hubbarth') THEN 'Strat Sales - Hubbarth'

      -- Strat Sales - Boston
      WHEN ${opportunity_owner} IN ('Mike Ternullo', 'Dominic Venuti', 'Brian Cincotta', 'Strat Sales - Boston') THEN 'Strat Sales - Boston'

      -- Strat Sales - Brown
      WHEN ${opportunity_owner} IN ('Ben Miller', 'Kate Schoenfeld', 'Emily Brown', 'Publicis Open Head') THEN 'Strat Sales - Brown'

      -- Strat Sales - Connon
      WHEN ${opportunity_owner} IN ('Kelly Jahrnes', 'Stephen Jensen', 'Amanda Pietruszka', 'Andi Wolf', 'Mike Connon', 'Ravenna Wilkins') THEN 'Strat Sales - Connon'

      -- Strat Sales - East
      WHEN ${opportunity_owner} IN ('Taylor Kiefer', 'Andrea St. Pierre', 'Strat Sales - East') THEN 'Strat Sales - East'

      -- Strat Sales - Rodriguez
      WHEN ${opportunity_owner} IN ('John Bohlinger', 'Todd Goldberg', 'Daniel Stein', 'Marisol Rodriguez') THEN 'Strat Sales - Rodriguez'

      -- Strat Sales - Wince
      WHEN ${opportunity_owner} IN ('Adam Wince', 'Colin Herbst', 'Gena Grossberg') THEN 'Strat Sales - Wince'

      -- Strat Sales - Southeast
      WHEN ${opportunity_owner} IN ('Mollie Darby', 'Rachel Locascio', 'Carolina Rivera', 'Tyler Conner') THEN 'Strat Sales - Southeast'

      -- Strat Sales - Southwest
      WHEN ${opportunity_owner} IN ('Lindsey Dobbs', 'Madison Holcomb', 'Denise Janowski', 'Glenn Sims', 'Michael Matijasevic', 'Haley Thompson', 'Brandon Bailey', 'Dan Thornton', 'New AE 1', 'Dianne Noriega Cairoli') THEN 'Strat Sales - Southwest'

      -- Strat Sales - Haddow
      WHEN ${opportunity_owner} IN ('Joe Ambrosio', 'Danielle Bracamonte', 'Lauren Burns', 'Andrew Scharkss', 'Igor Tsipis', 'Danielle Wolf', 'New Seller LA', 'Mark Haddow') THEN 'Strat Sales - Haddow'

      -- Strat Sales - Doherty
      WHEN ${opportunity_owner} IN ('Stephanie Haina', 'Tim Berman', 'Simon Chacham', 'Nina Ganelin', 'Alan Ibarra', 'Harrison Prewett', 'New Seller SF', 'Kent Nguyen', 'Kendall Doherty', 'Vanessa Guidi') THEN 'Strat Sales - Doherty'

      -- Strat Sales - West
      WHEN ${opportunity_owner} = 'Carine Spitz' THEN 'Strat Sales - West'

      ELSE NULL
    END ;;
}


  dimension: strat_sales_rvp {
    type: string
    label: "Strat Sales RVP"
    sql:
    CASE
          WHEN ${strat_sales_team} = 'Strat Sales - Canada' THEN 'Canada'

      WHEN ${strat_sales_team} IN ('Strat Sales - Central', 'Strat Sales - Budnick', 'Strat Sales - Ciesiolka', 'Strat Sales - Feder', 'Strat Sales - Hubbarth') THEN 'Central'

      WHEN ${strat_sales_team} IN ('Strat Sales - East', 'Strat Sales - Boston', 'Strat Sales - Brown', 'Strat Sales - Connon', 'Strat Sales - Rodriguez', 'Strat Sales - Wince') THEN 'East'

      WHEN ${strat_sales_team} = 'Strat Sales - Southeast' THEN 'South'

      WHEN ${strat_sales_team} = 'Strat Sales - Southwest' THEN 'South'

      WHEN ${strat_sales_team} IN ('Strat Sales - West', 'Strat Sales - Haddow', 'Strat Sales - Nguyen', 'Strat Sales - Doherty') THEN 'West'

      ELSE NULL
    END ;;
}


  #     WHEN ${strat_sales_team} IN (
  #       'Strat Sales - Central',
  #       'Strat Sales - Central 1',
  #       'Strat Sales - Central 2',
  #       'Strat Sales - Central 3',
  #       'Strat Sales - Central 4'
  #     ) THEN 'Central - Jeff Zito'

  #     WHEN ${strat_sales_team} IN (
  #     'Strat Sales - East',
  #     'Strat Sales - East 1',
  #     'Strat Sales - East 2',
  #     'Strat Sales - East 3',
  #     'Strat Sales - East 4',
  #     'Strat Sales - East 5',
  #     'Strat Sales - East 6'
  #     ) THEN 'East - Andrea St. Pierre'

  #     WHEN ${strat_sales_team} IN (
  #     'Strat Sales - West',
  #     'Strat Sales - West 1',
  #     'Strat Sales - West 2',
  #     'Strat Sales - West 3'
  #     ) THEN 'West - Sarineh Croft'

  #     ELSE NULL
  #     END
  #     ;;
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
