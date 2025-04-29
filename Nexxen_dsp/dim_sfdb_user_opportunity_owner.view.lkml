# The name of this view in Looker is "Dim Sfdb User Opportunity Owner"
view: dim_sfdb_user_opportunity_owner {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.dim_sfdb_user_opportunity_owner ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Opp Owner Company Name" in Explore.

  dimension: opp_owner_company_name {
    type: string
    sql: ${TABLE}.opp_owner_company_name ;;
    hidden: yes
  }

  dimension: opp_owner_division {
    type: string
    sql: ${TABLE}.opp_owner_division ;;
    hidden: yes
  }

  dimension: opp_owner_full_name {
    type: string
    label: "Opportunity Owner Name"
    sql: ${TABLE}.opp_owner_full_name ;;
  }

  dimension: opp_owner_id {
    type: string
    sql: ${TABLE}.opp_owner_id ;;
    hidden: yes
  }

  dimension: opp_owner_user_name {
    type: string
    sql: ${TABLE}.opp_owner_user_name ;;
    hidden: yes
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [opp_owner_full_name, opp_owner_user_name, opp_owner_company_name]
  }

  dimension: strat_sales_team {
    type: string
    label: "Strat Sales Team"
    sql:
    CASE
      -- Strat Sales - East
      WHEN ${TABLE}.opp_owner_full_name = 'Andrea St. Pierre' THEN 'Strat Sales - East'

      -- Strat Sales - East 4
      WHEN ${TABLE}.opp_owner_full_name IN ('Abbe Simmons', 'Adam Wince', 'Alex Miller', 'Gena Grossberg', 'John Bohlinger') THEN 'Strat Sales - East 4'

      -- Strat Sales - East 6
      WHEN ${TABLE}.opp_owner_full_name IN ('Brian Cincotta', 'Dominic Venuti', 'Mike Ternullo') THEN 'Strat Sales - East 6'

      -- Strat Sales - East 3
      WHEN ${TABLE}.opp_owner_full_name IN ('Ben Miller', 'Emily Brown', 'Kate Schoenfeld') THEN 'Strat Sales - East 3'

      -- Strat Sales - East 1
      WHEN ${TABLE}.opp_owner_full_name IN ('Amanda Pietruszka', 'Kelly Jahrnes', 'Mike Connon', 'Ray Conboy - Backfill', 'Taylor Kiefer', 'Stephen Jensen', 'Zachary Tamuzza') THEN 'Strat Sales - East 1'

      -- Strat Sales - East 5
      WHEN ${TABLE}.opp_owner_full_name IN ('Ryan Ammerman', 'Todd Goldberg') THEN 'Strat Sales - East 5'

      -- Strat Sales - East 2
      WHEN ${TABLE}.opp_owner_full_name IN ('Carolina Rivera', 'Mollie Darby', 'Sara Rethinger', 'Sydney Long') THEN 'Strat Sales - East 2'

      -- Strat Sales - Central
      WHEN ${TABLE}.opp_owner_full_name = 'Jeff Zito' THEN 'Strat Sales - Central'

      -- Strat Sales - Central 1
      WHEN ${TABLE}.opp_owner_full_name IN (
      'Collin Korab', 'Claire Riley', 'Jason Ciesiolka', 'Jennifer McCallum',
      'Kate Shepard', 'Katie Reisinger', 'Sara Ingold', 'Stuart Prentice',
      'Jeffrey Budnick', 'Ryan Kraft', 'Erin Frey', 'Jared Hinkel',
      'Jennifer Embler', 'Mitch Hubbarth', 'Wade Baxter'
      ) THEN 'Strat Sales - Central 1'

      -- Strat Sales - Central 2
      WHEN ${TABLE}.opp_owner_full_name IN (
      'Denise Janowski', 'Lindsey Dobbs', 'Ben Fichtenbaum', 'Madison Holcomb',
      'Dan Hammond', 'Haley Thompson', 'Brandon Bailey', 'Dan Thornton',
      'Glenn Sims', 'New Hire 1 - Central'
      ) THEN 'Strat Sales - Central 2'

      -- Strat Sales - Central 3
      WHEN ${TABLE}.opp_owner_full_name IN ('Adnan Khan', 'Mark Kates', 'Nick Catley', 'Sania Haider') THEN 'Strat Sales - Central 3'

      -- Strat Sales - West
      WHEN ${TABLE}.opp_owner_full_name = 'Sarineh Croft' THEN 'Strat Sales - West'

      -- Strat Sales - West 1
      WHEN ${TABLE}.opp_owner_full_name IN (
      'Abe Chami', 'Kent Nguyen', 'Nicole Richlak', 'Stephanie Haina',
      'Andrew Leary', 'Conner Johnson', 'Laura Grifka', 'Lauren Wiest',
      'Nina Ganelin', 'Tim Berman', 'Danielle Wolf - Kent'
      ) THEN 'Strat Sales - West 1'

      -- Strat Sales - West 2
      WHEN ${TABLE}.opp_owner_full_name IN (
      'Andrew Scharkss', 'Danielle Bracamonte', 'Joe Ambrosio', 'Jonathan Chiang',
      'Lauren Burns', 'Mark Haddow'
      ) THEN 'Strat Sales - West 2'

      -- Special case
      WHEN ${TABLE}.opp_owner_full_name = 'Danielle Wolf' THEN 'daniellewolf'

      ELSE NULL
      END ;;
  }

  dimension: strat_sales_rvp {
    type: string
    label: "Strat Sales RVP"
    sql:
    CASE
      WHEN ${strat_sales_team} IN (
        'Strat Sales - Central',
        'Strat Sales - Central 1',
        'Strat Sales - Central 2',
        'Strat Sales - Central 3',
        'Strat Sales - Central 4'
      ) THEN 'Central - Jeff Zito'

      WHEN ${strat_sales_team} IN (
      'Strat Sales - East',
      'Strat Sales - East 1',
      'Strat Sales - East 2',
      'Strat Sales - East 3',
      'Strat Sales - East 4',
      'Strat Sales - East 5',
      'Strat Sales - East 6'
      ) THEN 'East - Andrea St. Pierre'

      WHEN ${strat_sales_team} IN (
      'Strat Sales - West',
      'Strat Sales - West 1',
      'Strat Sales - West 2',
      'Strat Sales - West 3'
      ) THEN 'West - Sarineh Croft'

      ELSE NULL
      END
      ;;
  }

}
