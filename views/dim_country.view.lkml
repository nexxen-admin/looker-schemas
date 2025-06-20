view: dim_country {
  sql_table_name: BI_New.V_Dim_Country ;;

  dimension: continent {
    type: string
    sql: ${TABLE}.Continent ;;
  }

  dimension: country_code {
    label: "Country Code"
    description: "Country Short Name - describe the code of the country"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country_Code ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: country_name {
    label: "Country"
    map_layer_name: countries
    description: "Country Full Name"
    type: string
    sql: ${TABLE}.Country_Name ;;
  }

  dimension_group: db_create {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
  }

  dimension_group: db_update {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
  }

  dimension: region {
    label: "Region"
    description: "A region is an area of land that has common features, each country belong to specific area"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: ri_info {
    hidden: yes
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: country_filter {
    type: string
    sql: CASE WHEN ${TABLE}.Country_Name IN ('China', 'Indonesia', 'Pakistan', 'Bangladesh', 'Philippines', 'Vietnam', 'Iran', 'Turkey', 'Thailand', 'Myanmar', 'South Korea', 'Iraq', 'Afghanistan', 'Yemen', 'Uzbekistan', 'Malaysia', 'Saudi Arabia', 'Nepal', 'North Korea', 'Syria', 'Sri Lanka', 'Kazakhstan', 'Cambodia', 'Jordan', 'United Arab Emirates', 'Tajikistan', 'Azerbaijan', 'Israel', 'Laos', 'Turkmenistan', 'Kyrgyzstan', 'Singapore', 'Lebanon', 'State of Palestine', 'Oman', 'Kuwait', 'Georgia', 'Mongolia', 'Qatar', 'Armenia', 'Bahrain', 'Timor-Leste', 'Cyprus', 'Bhutan', 'Maldives', 'Brunei', 'Taiwan', 'Hong Kong', 'Macao', 'Papua New Guinea', 'Fiji', 'Solomon Islands', 'Vanuatu', 'Samoa', 'Kiribati', 'Micronesia', 'Tonga', 'Marshall Islands', 'Palau', 'Nauru', 'Tuvalu', 'New Caledonia', 'French Polynesia', 'Guam', 'American Samoa', 'Northern Mariana Islands', 'Cook Islands', 'Wallis & Futuna', 'Tokelau', 'Niue'
      ) THEN 'Asia & Oceania' ELSE ${TABLE}.Country_Name  END ;;
    hidden: yes
  }


}
