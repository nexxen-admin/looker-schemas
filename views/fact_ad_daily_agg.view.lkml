view: fact_ad_daily_agg {
  sql_table_name: BI_New.V_Fact_Ad_Daily_Agg ;;

  parameter: max_rank {
    type: number
    group_label: "Admins dim"
    hidden: yes
  }

  measure: impression_parameter {
    type: number
    sql: ${impression_pixel} ;;
    value_format: "0.00,,,\" B\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: revenue_parameter {
    type: number
    sql: ${Last_day_Revenue} ;;
    value_format: "$0.00,,\" M\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: request_parameter {
    type: number
    sql: ${Last_day_Requests} ;;
    value_format: "0.00,,,\" B\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }


  measure: Change_PubReq{
    type: number
    group_label: "Time Shifted Measures"
    label: "Pub Request Change Last Day"
    sql: ${pub_request_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: Change_Revenue{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Revenue Change Last Day"
    sql: ${revenue_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }
  measure: Change_imp{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Impressions Change Last Day"
    sql: ${impressions_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }
  measure: Change_BIDS{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Bids Change Last Day"
    sql: ${bids_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }
  measure: Change_InboundReq{
    type: number
    group_label: "Time Shifted Measures"
    label:  "Inbound Requests Change Last Day"
    sql: ${request_lastday_change_parameter};;
    value_format: "0.00%"
    html:

      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }





  measure: Bids_parameter {
    type: number
    sql: ${Last_day_bids} ;;
    value_format:"0.00,,,\" B\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: bidRate_parameter {
    type: number
    sql: ${Last_day_Bid_Rate} ;;
    value_format:  "0.00\%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: Net_Margin_parameter {
    type: number
    sql: ${Last_Day_net_Revenue} ;;
    value_format: "$0.00,\" K\""
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: revenue_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_Revenue}-${Previous_day_Revenue})/ NULLIF(${Previous_day_Revenue},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: impressions_lastday_change_parameter {
    type: number
    sql: COALESCE((${Last_day_impressions}-${Previous_day_impressions})/NULLIF(${Previous_day_impressions},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: request_lastday_change_parameter {
    type: number
    sql: COALESCE((${Last_day_Requests}-${Previous_day_Requests})/NULLIF(${Previous_day_Requests} ,0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: pub_request_lastday_change_parameter {
    type: number
    sql: coalesce((${Last_day_PubRequests}-${Previous_day_PubRequests})/NULLIF(${Previous_day_PubRequests} ,0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }


  measure: net_revenue_lastday_change_parameter {
    type: number
    sql: COALESCE((${Last_Day_net_Revenue}-${prev_Day_net_Revenue})/NULLIF(${prev_Day_net_Revenue},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: bids_lastday_change_parameter {
    type: number
    sql: COALESCE((${Last_Day_net_Revenue}-${prev_Day_net_Revenue})/NULLIF(${prev_Day_net_Revenue},0),0) ;;
    value_format: "0.00%"
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: revenue_change_parameter {
    type: number
    sql: case when ${revenue_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: impression_change_parameter {
    type: number
    sql: case when ${impressions_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: requests_change_parameter {
    type: number
    sql: case when ${request_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> {{value}} {{request_lastday_change_parameter._value}} </li>
    </ul> ;;
    hidden: yes

  }
  measure: bids_change_parameter {
    type: number
    sql: case when ${bids_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }
  measure: net_rev_change_parameter {
    type: number
    sql: case when ${net_revenue_lastday_change_parameter}>0
      then '▲'  else '▼' end;;
    html:
    <ul>
      <li> value: {{ value }} </li>
    </ul> ;;
    hidden: yes
  }

  measure: negative_change_meaures{
    type: number
    sql: case when
          ${net_revenue_lastday_change_parameter}<0 then 'Net Revenue'
          end;;
    html:
    <ul>  <li> value: {{ value }} </li>  </ul> ;;
    hidden: yes
  }

  measure: html_for_kpi{
    type: count
    html:  <div style="margin-right: 120px; display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
         <div style="display: block;  font-size: 20px;letter-spacing: 0.01em;">Impressions
        <div style="display: block; line-height: 10px; font-size: 25px;">{{ current_period_revenue._rendered_value }} {{impression_change_parameter._value}}
        <div style="display: block;  font-size: 10px;letter-spacing: 0.01em;"> {{ date_for_html._value }}
        <div style="display: inline-block; font-size: 15px;">
        <span class="drillable-item-content">  </span></span></span>
       </div></div>
       {{revenue_pop_change._rendered_value}} from  </div>
     </div> ;;
    group_label: "Admins Metrics"
  }

  measure: HTML_variable {
    type: count
    html:
    <div style="text-align:center; border-radius: 0px; padding: 5px 10px; background:#eeeeee; height: 60px; color: red;">

          <nav style="font-size: 18px;">
             <a style="color: #393838; padding: 5px 15px; line-height: 40px;" href="#home">Reports
             </a>
            <a style="color: #393838; padding: 5px 15px; line-height: 40px;" href="https://tremor.cloud.looker.com/dashboards-next/29">News️</a>
            <a style="color: #393838; padding: 5px 15px;line-height: 40px;" href="https://tremor.cloud.looker.com/extensions/marketplace_extension_data_dictionary::data-dictionary/models/Exchange/explores/fact_ad_daily_agg">Data Dictionary</a>
            <a style="color: #393838; padding: 5px 15px; line-height: 40px;" href="#about">Contact️</a>
          </nav>

      </div>
      <div>
      <img style= "width: 100%" src="https://i.ibb.co/nzf8gc7/Frame-4-1.png" alt="Frame-4-1" border="0">
      </div>
      <div style = "background:#ffffff;height: 60px; display: inline-block;text-align:center;width:100%"><h1 style=" font-family: Raleway ,Helvetica Neue,Helvetica,Arial,sans-serif;font-weight:700  ">Daily Matrics</h1> </div>
      <div style = "background:#393838;">
      <div style="margin-right: 120px; display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
      <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Impressions
      <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ impression_parameter._rendered_value }} {{impression_change_parameter._value}}

      <div style="display: inline-block; font-size: 15px;color:#fff">
      <span class="drillable-item-content">  </span></span></span>
      </div></div>
      {{impressions_lastday_change_parameter._rendered_value}} from past day </div>
      </div>
      <div style="margin-right: 120px; display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
      <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Requests {{requests_change_parameter._value}}
      <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ request_parameter._rendered_value }}
      <div style="display: inline-block; font-size: 15px;color:#fff">
      <span class="drillable-item-content">  </span></span></span>
      </div></div>
      {{request_lastday_change_parameter._rendered_value}} from past day </div>
      </div>
      <div style="display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
      <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Bids {{bids_change_parameter._value}}
      <div style= "display: block; line-height: 10px; font-size: 25px;color:#fff">{{ Bids_parameter._rendered_value }}
      <div style=" display: inline-block; font-size: 15px;color:#fff">
      <span class="drillable-item-content">  </span></span></span>
      </div></div>
      {{bids_lastday_change_parameter._rendered_value}} from past day </div>
      </div>
      </div>
      <div style = "background:#393838; margin-top: 10px;">
      <div style="margin-right: 120px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
      <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em">Revenue {{revenue_change_parameter._value}}
      <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ revenue_parameter._rendered_value }}
      <div style="display: inline-block; font-size: 15px;color:#fff">
      <span class="drillable-item-content">  </span></span></span>
      </div></div>
      {{revenue_lastday_change_parameter._rendered_value}} from past day </div>
      </div>

      <div style="margin-right: 120px;display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
      <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em;">Impressions {{impression_change_parameter._value}}
      <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ impression_parameter._rendered_value }}
      <div style="display: inline-block; font-size: 15px;color:#fff">
      <span class="drillable-item-content">  </span></span></span>
      </div></div>
      {{impressions_lastday_change_parameter._rendered_value}} from past day </div>
      </div>
      <div style=" display: inline-block ;linear-gradient(180deg, rgba(2, 12, 13, 0.03) 18.92%, rgba(2, 12, 13, 0) 79.34%);">
      <div style="display: block;  font-size: 20px; color:#fff;letter-spacing: 0.01em">Net Revenue {{net_rev_change_parameter._value}}
      <div style="display: block; line-height: 10px; font-size: 25px;color:#fff">{{ Net_Margin_parameter._rendered_value }}
      <div style="display: inline-block; font-size: 15px;color:#fff">
      <span class="drillable-item-content">  </span></span></span>
      </div></div>
      {{net_revenue_lastday_change_parameter._rendered_value}} from past day </div>
      </div>
      </div>

      <div>
      <a href="https://tremor.cloud.looker.com/explore/Exchange/fact_ad_daily_agg"><img  style= "width:100%"  src= "https://i.ibb.co/7WgQTps/Frame-3-1.png" alt="Frame-3-1" border="0">"></a>
      </div>
      <div style="text-align:center; border-radius: 0px;  padding: 5px 10px; background:#393838; height: 60px; color: red;">

      <nav style="font-size: 18px;">
      <img style=" width;100px ;padding: 5px 15px; float: left; height: 40px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABaAA…prs+779J3Te6590L1/j8HLRpR86ZVlgAAAABJRU5ErkJggg==">
      <a style="color: #efefef; padding: 5px 15px; line-height: 40px;" href="#home">Reports 📊 </a>
      <a style="color: #efefef; padding: 5px 15px; line-height: 40px;" href="#news">News 📜</a>
      <a style="color: #efefef; padding: 5px 15px;line-height: 40px;" href="#contact">Data Dictionary❓</a>
      <a style=" color: #efefef; padding: 5px 15px; line-height: 40px;" href="#about">Contact️ 📒</a>
      </nav>

      ;;
    group_label: "Admins Metrics"
  }

  measure: HTML_variable2 {
    type: count
    html:

      <table>
      <tr>
        <th><div style="text-align: left; margin:72px 72px;">
      <img style="width:400px" src="https://www.tremorinternational.com/wp-content/uploads/2022/01/Ti_logo_black-fitted.svg">
      </div></th>
        <th><div style ="vertical-align: bottom;padding-top:50px;text-align:right;">| Business Intelligence Platform</div></th>
      </tr>
    </table>

      <div style = "margin:5px 72px 72px 72px; text-align:left; ">Hey {{ _user_attributes['name'] }},<br>

      <div><a style="float:right; color: #FFFFFF; background-color:#000000; border: solid 3px #000000; font-weight: 400;height:70px;
      text-align: center;text-float: center; vertical-align: middle;cursor: pointer;user-select: none;padding: 30px 120px 30px 120px ;margin-left:900px;font-size:30px;
      line-height: 0px; border-radius: 25px" href="https://tremor.cloud.looker.com/extensions/marketplace_extension_data_dictionary::data-dictionary/models/Exchange/explores/fact_ad_daily_agg">Data Dictionary </a><p style = "float:none;font-size:20px;line-height: 1.6; color:#000000;">
      Browse through the data dictionary to find definitions, restrictions<br style= "line-height:1px">
      and general information about the dimensions and measures you're using  <br>
      in your reports.
      All missing descriptions will be added shortly. <strong></strong></p>
      </div>

      <div><a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:70px;
      text-align: center; vertical-align: middle;cursor: pointer;user-select: none;padding: 30px 110px 30px 110px ;margin-left:900px;font-size:30px;
      line-height: 0px;  border-radius: 25px" href="https://tremor.cloud.looker.com/dashboards/162">Looker Academy </a><p style = "font-size:20px;line-height: 1.6; color:#000000;">
      Visit the new site to find learning experiences <br style= "line-height:1px">
      with self-paced education and hands-on practice <br>
      designed to get you up to speed quickly. <strong></strong></p></div>


      <div><a style="float:right;  color: #FFFFFF; background-color:#000000;  border: solid 3px #000000;x font-weight: 400;height:70px;
      text-align: center; vertical-align: middle;cursor: pointer;user-select: none;padding:30px 145px 30px 145px ;margin-left:900px;font-size:30px;
      line-height: 0px;  border-radius: 25px" href="https://tremor.cloud.looker.com/dashboards/29">News Page </a><p style = "font-size:20px;line-height: 1.6; color:#000000;">
      Stay up to date on what's new in Looker!<br style= "line-height:1px">
      New additions and important BI information will be added to the news page.<br>
      You will receive an update in the slack group with a link <br>
      to the news page.<strong></strong></p></div>
      </div>
      <img style="width:1350px" src="https://d15k2d11r6t6rl.cloudfront.net/public/users/Integrators/BeeProAgency/632029_614016/Header-03.jpg">

      ;;


    group_label: "Admins Metrics"
  }

  measure: video_2 {
    type: count
    html:

      <div><a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin; font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a>
          <a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin;font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a>
          <a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin;font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a>
         <a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin;font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a></div>
          <div><a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin; font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a>
          <a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin;font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a>
          <a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin;font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a>
         <a style="float:right; color:#FFFFFF; background-color:#000000;  border: solid 3px #000000; font-weight: 400;height:350px; width: 350px;
           text-align: center; vertical-align: middle; cursor: pointer;user-select: none;padding:  ;margin;font-size:30px;
           line-height: 350px;  border-radius: 50%" href="#home">Looker Academy </a></div>;;

  }

  measure: video_3 {
    type: count
    html:

    <table>
      <tr>
        <th><div style = "display: inline-block">

      <video width="800" height="450" controls>
      <source src="https://tremorinternational-my.sharepoint.com/:v:/r/personal/chen_tal_unrulygroup_com/Documents/looker%20academy/Opener%20with%20Sound-Pending%20Chen%20Approval/Ep01_Building%20My%20First%20Report.mp4" type="video/mp4">
      </video>
      <p style = "font-size:20px;line-height: 1.6; color:#000000;">Buiding My first Looker Report<style= "line-height:1px">
      </div>
      </th>
      <th><p style = "font-size:20px;line-height: 1.6; color:#FFFFFF;"> | </p></th>

      <th><div style = "display: inline-block">

      <video width="800" height="450" controls>
      <source src="https://tremorinternational-my.sharepoint.com/:v:/r/personal/chen_tal_unrulygroup_com/Documents/looker%20academy/Opener%20with%20Sound-Pending%20Chen%20Approval/Ep02_Save%20Report%20to%20Personal%20Folder.mp4" type="video/mp4">
      </video>
      <p style = "font-size:20px;line-height: 1.6; color:#000000;">Saving a Report to my Personal Folder<style= "line-height:1px">
      </div>
      </th>
      </tr>
      <tr>
      <th><div style = "display: inline-block">

      <video width="800" height="450" controls>
      <source src="https://tremorinternational-my.sharepoint.com/:v:/r/personal/chen_tal_unrulygroup_com/Documents/looker%20academy/Opener%20with%20Sound-Pending%20Chen%20Approval/Ep03_Save%20Report%20to%20Existing%20Dashboard.mp4" type="video/mp4">
      </video>
      <p style = "font-size:20px;line-height: 1.6; color:#000000;">Saving a Report to an Existing Dashboard<style= "line-height:1px">
      </div>
      </th>
      <th><div style = "display: inline-block"> </th>
      <th><div style = "display: inline-block">

      <video width="800" height="450" controls>
      <source src="https://tremorinternational-my.sharepoint.com/:v:/r/personal/chen_tal_unrulygroup_com/Documents/looker%20academy/Opener%20with%20Sound-Pending%20Chen%20Approval/Ep04_Add%20New%20Filters.mp4" type="video/mp4">
      </video>
      <p style = "font-size:20px;line-height: 1.6; color:#000000;">Applying Filters<style= "line-height:1px">
      </div>
      </th>
      </tr>
      </table>

      ;;

  }

  measure: video_4 {

    type: count
    html:


    <table>
            <tr>
                <td style = "padding: 2px">
                  <video controls width="480" poster = "https://tremorinternational.sharepoint.com/:i:/r/sites/BIDevelopment/Shared%20Documents/Looker%20Academy/Opener%20with%20Sound-Pending%20Chen%20Approval/ep_01_static.png">
                  <source src="https://tremorinternational.sharepoint.com/:v:/r/sites/BIDevelopment/Shared%20Documents/Looker%20Academy/Opener%20with%20Sound-Pending%20Chen%20Approval/Ep01_Building%20My%20First%20Report.mp4" type="video/mp4">
                  </video>
                </td>

      <td>
      <p style = "font-size:20px;line-height: 1.6; color:#FFFFFF;"> | </p>
      </td>

      <td style = "padding: 2px">
      <video controls width="480" poster = "https://tremorinternational.sharepoint.com/:i:/r/sites/BIDevelopment/Shared%20Documents/Looker%20Academy/Opener%20with%20Sound/ep_02_static.png?csf=1&web=1&e=MBdDCb">
      <source src="https://tremorinternational.sharepoint.com/:v:/r/sites/BIDevelopment/Shared%20Documents/Looker%20Academy/Opener%20with%20Sound/EP_02_Mar3.mp4?csf=1&web=1&e=EvFlDG" type="video/mp4">
      </video>
      </td>

      <td>
      <p style = "font-size:20px;line-height: 1.6; color:#FFFFFF;"> | </p>
      </td>

      <td style = "padding: 2px">
      <video controls width="480" poster = "https://tremorinternational.sharepoint.com/:i:/r/sites/BIDevelopment/Shared%20Documents/Looker%20Academy/Opener%20with%20Sound-Pending%20Chen%20Approval/ep_03_static.png">
      <source src="https://tremorinternational.sharepoint.com/:v:/r/sites/BIDevelopment/Shared%20Documents/Looker%20Academy/Opener%20with%20Sound-Pending%20Chen%20Approval/EP_03_Mar3.mp4" type="video/mp4">
      </video>
      </td>
      </tr>

      <tr>
      <td >
      <h1 style = "font-size:18px;line-height: 1.6; color:#000000;text-align: left;">Building My First Report</h1>
      <p style = "font-size:16px;line-height: 1.2; color:#71767A;text-align: left;">Learn how to add dimetions and measures and how to filter your report</p>
      </td>
      <td>
      <p style = "font-size:20px;line-height: 1.6; color:#FFFFFF;text-align: left;"> | </p>
      </td>

      <td>
      <h1 style = "font-size:18px;line-height: 1.6; color:#000000;text-align: left;">Saving a Report to my Personal Folder</h1>
      <p style = "font-size:16px;line-height: 1.2; color:#71767A;text-align: left;">Learn how to save your report into your own personal folder</p>
      </td>
      <td>
      <p style = "font-size:20px;line-height: 1.6; color:#FFFFFF;text-align: left;"> | </p>
      </td>
      <td>
      <h1 style = "font-size:18px;line-height: 1.6; color:#000000;text-align: left;">Saving a Report to an Existing Dashboard</h1>
      <p style = "font-size:16px;line-height: 1.2; color:#71767A;text-align: left;">Learn how to add a new look to an existing dashboard</p>
      </td>

      </tr>
      </table>

      ;;


  }

  dimension: rank_limit {
    type: number
    group_label: "Admins dim"
    sql: {% parameter max_rank %} ;;
    hidden: yes
  }

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
    hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    description: "Media Cost (3rd Party SSP or Publisher Cost) - align to cost in CTRL platform"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cogs ;;
  }

  measure:: cost {
    label: "Cost"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cost ;;
  }

  measure: click_count {
    type: sum
    label: "Clicks"
    description: "Number of clicks on the video"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_click_count ;;
    #hidden: yes
  }

  measure: deal_count {
    type: sum
    label: "Deal Count"
    description: "Count of deals"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_deal_count ;;
    #hidden: yes
  }



  measure:: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_measurable_impression ;;
  }

  measure:: ias_viewability {
    type: number
    description: "Analyses the video views amount"
    value_format: "0.00\%"
    label: "IAS Viewability"
    group_label: "Daily Measures"
    sql: ${ias_viewable_impression}/NULLIF(${ias_measurable_impression},0);;
  }

  measure: moat_impressions_ivt {
    type: sum
    label: "Moat Impressions IVT"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_moat_impressions_ivt ;;
    #hidden: yes
  }

  measure: moat_impressions_ivt_measurable {
    type: sum
    label: "Moat Measurable Impressions IVT"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_moat_impressions_ivt_measurable ;;
    #hidden: yes
  }

  measure: moat_impressions_viewable {
    type: sum
    label: "Moat Impressions Viewable"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_moat_impressions_viewable ;;

  }

  measure: moat_impressions_viewable_measurable {
    type: sum
    label: "Moat Impressions Viewable Measurable"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_moat_impressions_viewable_measurable ;;
    #hidden: yes
  }

  measure:: Moat_viewability {
    type: number
    description: "Analyses the video views amount"
    value_format: "0.00\%"
    label: "Moat Viewability"
    group_label: "Daily Measures"
    sql: ${moat_impressions_viewable}/NULLIF(${moat_impressions_viewable_measurable},0);;

  }


  measure: rmp_attempts {
    type: sum
    label: "RMP Attempts"
    description: "When the SSP sends back the bid response to the publisher"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_rmp_attempts ;;
    # hidden: yes
  }

  measure: slot_attempts {
    type: sum
    label: "Slot Attempts"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_slot_attempts ;;
    # hidden: yes
  }

  measure: ias_viewability_score {
    type: sum
    label: "IAS Predicted Viewability Score"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_viewability_score ;;
    hidden: yes
  }

  measure:: ias_total_impression {
    type: sum
    label: "IAS Total Impression"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_total_impression ;;

  }
  measure:: ias_ivt_impression {
    type: sum
    label: "IAS IVT Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_ivt_impression ;;

  }
  measure:  ias_ivt_rate_calc{
    type: number
    label: "IAS IVT Rate"
    group_label: "Daily Measures"
    value_format: "0.00\%"
    sql: (${ias_ivt_impression}/NULLIF(${ias_total_impression},0))*100 ;;

  }

  measure: ias_ivt_rate {
    type: average
    label: "IAS Predicted IVS Rate"
    value_format: "0.00\%"
    sql: ${TABLE}.avg_of_ias_ivt_rate/100 ;;
    hidden: yes
  }



  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_viewable_impression ;;
  }

  measure:: video_completes {
    type: sum
    label: "Video Completes"
    description: "Number of times the video has been completed"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_completes ;;
    #hidden: yes
  }

  measure:: video_starts {
    type: sum
    label: "Video Starts"
    description: "Number of times the video has been started"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_starts ;;
    #hidden: yes
  }

  measure: video_creative_views {
    type: sum
    label: "Video Creative Views"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_creative_views ;;
    #hidden: yes
  }

  measure: slot_requests {
    type: sum
    label: "Slot Requests"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_slot_requests ;;

  }



  measure: video_errors {
    type: sum
    label: "Video Errors"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_errors ;;
    #hidden: yes
  }


  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: platformfee_type_key {
    type: number
    sql: ${TABLE}.Platformfee_Type_Key ;;
    hidden: yes
  }

  dimension_group: date_key {
    type: time
    timeframes:
    [ date,
      month,
      week,
      year,
      quarter,
      raw
    ]
    label: "Date"
    group_label: "Time Frame"
    sql: ${TABLE}.Date_Key ;;
    #hidden: yes
  }

  measure: min_date_key {
    type:date
    label: "min Date"
    group_label: "Time Frame"
    sql:  min(${TABLE}.Date_Key) ;;

    #hidden: yes
  }


  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes

  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_flight_key {
    type: number
    sql: ${TABLE}.DSP_Flight_Key ;;
    hidden: yes
  }


  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
    hidden: yes
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
    hidden: yes
  }

  dimension: imp_sub_type_key {
    type: number
    sql: ${TABLE}.Imp_SubType_Key ;;
    hidden: yes
  }

  dimension: buying_channel_key {
    type: number
    sql: ${TABLE}.Buying_Channel_Key ;;
    hidden: yes
  }

  dimension: data_center_key {
    type: number
    sql: ${TABLE}.DataCenter_Key ;;
    hidden: yes
  }

  dimension: imp_type_key {
    type: number
    sql: ${TABLE}.Imp_Type_Key ;;
    hidden: yes
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
    hidden: yes
  }

  dimension: rg_blocked_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Key ;;
    hidden: yes
  }
  dimension: rg_blocked_reason_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Reason_key ;;
    hidden: yes
  }
  dimension: user_matched_key {
    type: number
    sql: ${TABLE}.user_Matched_Key ;;
    hidden: yes
  }
  dimension: video_Linearity_key {
    type: number
    sql: ${TABLE}.video_Linearity_key ;;
    hidden: yes
  }
  dimension: video_simple_size_key {
    type: number
    sql: ${TABLE}.video_simple_size_key ;;
    hidden: yes
  }
  dimension: ad_size_height_key {
    type: number
    sql: ${TABLE}.Ad_Size_Height_Key ;;
    hidden: yes
  }
  dimension: ad_size_width_key {
    type: number
    sql: ${TABLE}.Ad_Size_Width_Key;;
    hidden: yes
  }

  dimension: media_type_key {
    type: number
    sql: ${TABLE}.Media_Type_Key ;;
    hidden: yes
  }

  dimension: media_name_key {
    type: number
    sql: ${TABLE}.Media_Name_Key ;;
    hidden: yes
  }

  dimension: dsp_deal_type_key {
    type: number
    sql: ${TABLE}.DSP_Deal_Type_Key ;;
    hidden: yes
  }

  measure: impression_pixel {
    type: sum
    label: "Impressions"
    description: "Successfully delivered ad impression. Billable event"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_pixel ;;
  }

  dimension: impression_pixel2 {
    type: number
    label: "Impressions DIM"
    description: "Successfully delivered ad impression. Billable event"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_pixel ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    description: "The win event posts our bid response back to the publisher/ssp, indicating that we have won the bid in their auction"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_win ;;
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
    hidden: yes
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
    hidden: yes
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
    hidden: yes
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
    hidden: yes
  }

  measure: requests {
    type: sum
    description: "Requests sent to us from the publisher / ssp to the exchange. This count is prior to any filtering and determination of which DSPs the requests are sent to and which Deals are attached to the request"
    label: "Inbound Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_requests ;;
  }

  measure: Bid_Rate {
    type: number
    label: "Bid Rate"
    description: "responses/requests"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${responses}/NULLIF(${requests},0))*100 ;;
  }

  measure: Fill_Rate {
    type: number
    description: "Number of impressions out of the requests"
    label: "Fill Rate"
    value_format: "0.00%"
    group_label: "Daily Measures"
    sql: (${impression_pixel}/NULLIF(${requests},0))*100 ;;
  }

  measure: Net_Revenue {
    type: number
    description: "Difference between revenue and cogs"
    label: "Net Revenue"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue} - ${cogs} ;;
  }

  filter: publisher_filter {
    type: string
    suggest_dimension: pub_ssp_key
  }

  dimension: publisher_filter_filter {
    type: yesno
    hidden: yes
    sql: {% condition publisher_filter %} ${pub_ssp_key} {% endcondition %} ;;
  }

  measure: sum_dynamic_pub {
    type: sum
    sql: ${TABLE}.sum_of_revenue ;;
    filters: [publisher_filter_filter: "yes"]
  }

  measure: Margin {
    type: number
    label: "Margin%"
    description: "Difference between revenue and cogs out of total revenue"
    value_format: "0.00%"
    group_label: "Daily Measures"
    sql: ((${revenue} - ${cogs})/NULLIF(${revenue},0)) ;;
  }

  measure: Pub_eCPM {
    type: number
    label: "Pub eCPM"
    description: "cogs/impressions"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: (${cogs}/NULLIF(${impression_pixel},0))*1000 ;;
  }

  measure: Pub_RPM {
    type: number
    label: "Pub RPM"
    description: "revenue/impressions"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: (${revenue}/NULLIF(${impression_pixel},0))*1000 ;;
  }


  measure: Render_Rate {
    type: number
    description: "impressions/wins"
    label: "Render Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${impression_pixel}/NULLIF(${impression_win},0))*100 ;;
  }

  measure: Response_Rate {
    type: number
    description: "responses/requests"
    label: "Response Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${responses}/NULLIF(${requests},0))*100 ;;
  }

  measure: RPM {
    type: number
    label: "RPM"
    description: "revenue/requests"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue}/NULLIF((${requests}/1000000),0) ;;
  }

  measure: VTR {
    type: number
    description: "Number of times the video has been completed out of all the impressions it had"
    label: "VTR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${video_completes}/NULLIF(${impression_pixel},0))*100;;
  }

  measure: VCR {
    type: number
    description: "Number of times the video has been completed out of the times it has started"
    label: "VCR"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${video_completes}/NULLIF(${video_starts},0))*100;;

  }

  measure: CTR {
    type: number
    label: "CTR"
    description: "Number of video clicks out of the impressions"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${click_count}/NULLIF(${impression_pixel},0))*100;;
  }

  measure: Win_Rate {
    type: number
    description: "wins/responses"
    label: "Win Rate"
    value_format: "0.00\%"
    group_label: "Daily Measures"
    sql: (${impression_win}/NULLIF(${responses},0))*100;;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    label: "Bids"
    description: "Bid responses returned from dsps. There may be more than one bid response per bid request.   "
    value_format: "#,##0"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_responses ;;
  }

  measure: revenue
  {
    type: sum
    label: "Revenue"
    #sql_distinct_key: ${deal_key} ;;
    description: "Amount of money we earned"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_revenue;;
  }
  # dimension: revenue_d
  # {
  #   type: number
  #   label: "Revenue_d"
  #   #sql_distinct_key: ${deal_key} ;;
  #   value_format: "$#,##0.00"
  #   #group_label: "Daily Measures"
  #   sql: ${TABLE}.sum_of_revenue;;
  # }

  measure: MediaMath_Revenue {
    type: sum
    label: "MediaMath Revenue"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: case when ${dsp_key} in ('3900006','4600005') then ${TABLE}.sum_of_revenue
      else '0' end;;
  }

  measure: MediaMath_Rebate_value {
    type: number
    label: "MediaMath Rebate Value"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: case when ${dsp_key} in ('3900006','4600005') then ((${MediaMath_Revenue})-1000000)*0.5
      else '0' end;;
  }

  measure: MediaMath_Rebate_Percent {
    type: number
    label: "MediaMath_Rebate_Percent"
    value_format:"0.00\%"
    group_label: "Daily Measures"
    sql:  ((${MediaMath_Revenue}-1000000)*0.5)/${MediaMath_Revenue}
      ;;
  }

  measure: MM_NC_Rebate {
    type: number
    label: "MM NC Rebate"
    value_format: "#,##0.0"
    group_label: "Daily Measures"
    sql: case when dsp_key in ('4900006','4600005','4400008','4900006','4800007','5100008','3900006','5000005') and
           (case WHEN ((pub_key in ('5200026','5300019','3500026','5100027','3300025','3300025','3000031','4700048') and
                     ssp_key in ('3000003','3400010','3500005','3600004','3800001','3800002','4000002','4000003','4100003','4100004','4500005','5000003','5600006','5600008','434400001'))
                     or (ssp_key in ('3000003','3400010','3500005','3600004','3800001','3800002','4000002','4000003','4100003','4100004','4500005','5000003','5600006','5600008','434400001') and ${TABLE}.Placement_Key
                       in ('8980315','13780125','16881034','3000164','29381285','42581092','16881035','16881036'))
                         then 1 else 0 end) =1 then ${revenue} else 0 end) * 0.0335259539604279 * -1;;
  }

  measure: revenue_test
  {
    type: sum
    label: "Revenue_test"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_revenue/1 ;;
    hidden: yes
  }

  measure: Ad_eCPM{
    type: number
    description: "revenue/impressions"
    label: "Ad eCPM"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${revenue}/NULLIF((${impression_pixel}/1000),0) ;;
  }


  measure:  Previous_day_Revenue {
    label: "Revenue Previous day "
    type: sum
    description: "The revenue of 2 days ago"
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "2 days ago"]

  }

  measure: revenue_lastday_change {
    type: number
    description: "Change in revenue from 2 days ago to yesterday"
    value_format: "0.00%"
    group_label: "Time Shifted Measures"
    sql: (${Last_day_Revenue}/${Previous_day_Revenue})-1 ;;

  }

  measure:  Previous_week_Revenue {
    label: "Revenue Previous week "
    type: sum
    description: "The revenue of 2 weeks ago"
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "2 weeks ago"]

  }

  measure:  last_week_Revenue {
    label: "Revenue last week "
    type: sum
    description: "The revenue of 8 days ago (last day of last week)"
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "8 days ago"]

  }


  measure:  last_month_Revenue {
    label: "Revenue last month "
    type: sum
    description: "The revenue of 32 days ago (last day of last month)"
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "32 days ago"]

  }

  measure:  last_week_Impressions {
    label: "Impressions last week "
    type: sum
    description: "The impressions of 8 days ago (last day of last week)"
    sql: ${TABLE}.sum_of_impression_pixel ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "8 days ago"]

  }

  measure:  last_Month_Impressions {
    label: "Impressions last month "
    type: sum
    description: "The impressions of 32 days ago (last day of last month)"
    sql: ${TABLE}.sum_of_impression_pixel ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "32 days ago"]

  }


  measure:  Previous_day_Requests {
    label: "Requests Previous day "
    type: sum
    description: "The bid requests of 2 days ago"
    sql: ${TABLE}.sum_of_requests ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]
  }

  measure:  Previous_day_PubRequests {
    label: "Pub Requests Previous day "
    type: sum
    description: "The pub requests of 2 days ago"
    sql: ${TABLE}.sum_of_rmp_requests ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]
  }

  measure:  Seven_day_PubRequests {
    label: "Pub Requests 7 days ago "
    type: sum
    description: "The pub requests of 7 days ago"
    sql: ${TABLE}.sum_of_rmp_requests ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "7 days ago"]
  }

  measure:  MonthAgo_PubRequests {
    label: "Pub Requests 28 days ago "
    type: sum
    description: "The pub requests of 28 days ago"
    sql: ${TABLE}.sum_of_rmp_requests ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "28 days ago"]
  }

  measure:  Previous_day_impressions {
    label: "Impressions Previous day "
    type: sum
    description: "The impressions of 2 days ago"
    sql: ${TABLE}.sum_of_impression_pixel ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]

  }

  measure:  previous_day_Bid_Rate {
    label: "Bid Rate Previous day"
    type: sum
    description: "responses/requests of 2 days ago"
    sql: ${TABLE}.sum_of_responses/NULLIF(${TABLE}.sum_of_requests,0) ;;
    value_format: "0.00\%"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "2 days ago"]

  }
  measure: previous_day_responses {
    type: sum
    label: "Bids Previous day"
    description: "The responses of 2 days ago"
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.dim_of_responses  ;;
    filters: [date_key_date: "2 days ago"]

  }

  measure: prev_Day_net_Revenue {
    type: sum
    label: "Net Revenue prev Day"
    description: "The net revenue (difference between revenue and cogs) of 2 days ago"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.sum_of_cogs  ;;
    filters: [date_key_date: "2 days ago"]

  }

  measure: last_week_net_Revenue {
    type: sum
    label: "Net Revenue Last Week"
    description: "The difference between revenue an cogs of 8 days ago"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.sum_of_cogs  ;;
    filters: [date_key_date: "8 days ago"]

  }

  measure: last_month_net_Revenue {
    type: sum
    description: "The difference between revenue an cogs of 32 days ago"
    label: "Net Revenue Last Month"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.sum_of_cogs  ;;
    filters: [date_key_date: "32 days ago"]

  }

  measure:  last_week_Requests {
    label: "Requests last week "
    type: sum
    description: "The requests of 8 days ago"
    sql: ${TABLE}.sum_of_requests ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "8 days ago"]

  }

  measure:  last_month_Requests {
    label: "Requests last month "
    type: sum
    description: "The requests of 32 days ago"
    sql: ${TABLE}.sum_of_requests ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "32 days ago"]

  }

  measure:  prev_day_attempts {
    label: "Attempts previous day "
    type: sum
    sql: ${TABLE}.sum_of_slot_attempts ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "2 days ago"]

  }

  measure:  last_day_attempts {
    label: "Attempts last day "
    type: sum
    sql: ${TABLE}.sum_of_slot_attempts ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "1 days ago"]

  }

  measure:  last_week_attempts {
    label: "Attempts last week "
    type: sum
    sql: ${TABLE}.sum_of_slot_attempts ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "8 days ago"]

  }


  measure:  last_month_attempts {
    label: "Attempts last month "
    type: sum
    sql: ${TABLE}.sum_of_slot_attempts ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "32 days ago"]

  }

  measure: pub_platform_fee {
    type: sum
    label: "pub_platform_fee"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_pub_platform_fee ;;
  }

  measure:  Last_day_Revenue {
    label: "Revenue Last day "
    type: sum
    description: "The last day revenue"
    sql: ${TABLE}.sum_of_revenue ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_7_Days_Revenue{
    label: "Revenue Last 7 Days"
    type: sum
    description: "The revenue of the last 7 days"
    sql: ${TABLE}.sum_of_revenue;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "7 days ago for 7 days"]
  }

  measure: Prior_Week_Revenue{
    label: "Revenue Prior Week"
    type: sum
    description: "The revenue of the previous week (14 to 8 days ago)"
    sql: ${TABLE}.sum_of_revenue;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "14 days ago for 7 days"]
  }

  measure: Last_Month_Revenue{
    label: "Revenue Prior Month"
    type: sum
    description: "The revenue of 28 to 22 days ago"
    sql: ${TABLE}.sum_of_revenue;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "28 days ago for 7 days"]
  }

  measure: Last_7_Days_Cogs{
    label: "Cogs Last 7 Days"
    type: sum
    description: "The cogs of the last 7 days"
    sql: ${TABLE}.sum_of_cogs;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "7 days ago for 7 days"]
  }

  measure: Prior_Week_Cogs{
    label: "Cogs Prior Week"
    type: sum
    description: "The cogs of the previous week (14 to 8 days ago)"
    sql: ${TABLE}.sum_of_cogs;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "14 days ago for 7 days"]
  }

  measure: Last_Month_Cogs{
    label: "Cogs Prior Month"
    type: sum
    description: "The cogs of 28 to 22 days ago"
    sql: ${TABLE}.sum_of_cogs;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0"
    filters: [date_key_date: "28 days ago for 7 days"]
  }

  measure:  Last_day_cogs {
    label: "Cogs Last day "
    type: sum
    description: "The cogs of the last day"
    sql: ${TABLE}.sum_of_cogs ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_impressions {
    label: "Impressions Last day "
    type: sum
    description: "The impressions of the last day"
    sql: ${TABLE}.sum_of_impression_pixel ;;
    value_format: "#,##0.00"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_Day_net_Revenue {
    type: sum
    description: "The difference between revenue and cogs of the last day"
    label: "Net Revenue Last Day"
    value_format: "$#,##0.00"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.sum_of_cogs  ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure: Last_day_bids {
    type: sum
    description: "The bid reponses of the last day"
    label: "Bids Last day"
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    sql: ${TABLE}.sum_of_responses ;;
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_Requests {
    label: "Requests Last day "
    type: sum
    description: "The requests of the last day"
    sql: ${TABLE}.sum_of_requests ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }
  measure:  Last_day_PubRequests {
    label: "Pub Requests Last day "
    type: sum
    description: "The pub requests of the last day"
    sql: ${TABLE}.sum_of_rmp_requests ;;
    value_format: "#,##0"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }

  measure:  Last_day_Bid_Rate {
    label: " Bid Rate Last day"
    type: sum
    description: "response/requests of the last day"
    sql: ${TABLE}.sum_of_responses/NULLIF(${TABLE}.sum_of_requests,0) ;;
    value_format: "0.00\%"
    group_label: "Time Shifted Measures"
    filters: [date_key_date: "last 1 day ago for 1 day"]
  }


  measure: rmp_requests {
    type: sum
    description: "Requests sent to us from the publisher only to the exchange. This count is prior to any filtering and determination of which DSPs the requests are sent to and which Deals are attached to the request"
    label: "Pub Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_rmp_requests ;;
  }

  measure: rx_bid_floor {
    type: average
    description: "The bid floor every publisher determines. every bid price below it will be immediately filtered out"
    label: "Bid Floor"
    group_label: "Daily Measures"
    sql: ${TABLE}.avg_of_ssp_bid_floor ;;
    # hidden: yes
  }

  dimension: dsp_bid_price {
    type: number
    description: "The bid price every advertiser is willing to pay on an ad"
    label: "Bid Price"
    sql: ${TABLE}.avg_of_dsp_bid_price ;;
    # hidden: yes
  }

  dimension: Genre_Norm_Key {
    type: number
    label: "Genre Norm Key"
    sql: ${TABLE}.Genre_Norm_Key;;
    hidden: yes
  }

  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;


  }
  dimension:  date_for_html {
    type: date
    view_label: "PoP"
    sql: ${current_date_range} ;;
    html:
    <ul>
         <li> value: {{ rendered_value }} </li>
    </ul> ;;

  }



  parameter: compare_to {
    view_label: "PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "Compare To:"
    type: unquoted

    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }

    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }

  parameter: choose_breakdown {
    label: "Choose Grouping"
    view_label: "PoP"
    type: unquoted
    default_value: "day_of_month"
    allowed_value: {label:"daily" value:"day_of_month"}
    allowed_value: {label:"monthly" value: "month_name"}
  }

## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##
  dimension: sort_by1 {
    hidden: yes
    type: number
    sql:
        {% if choose_breakdown._parameter_value == 'month_name' %} ${date_in_period_month_num}
        {% elsif choose_breakdown._parameter_value == 'day_of_month' %} ${date_in_period_day_of_month}
        {% elsif choose_breakdown._parameter_value == 'year' %} ${date_in_period_year}}
        {% elsif choose_breakdown._parameter_value == 'quarter' %} ${date_in_period_quarter}
        {% else %}NULL{% endif %} ;;
  }
  dimension: sort_by2 {
    hidden: yes
    type: string
    sql:
        {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
        {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month_num}
        {% else %}NULL{% endif %} ;;
  }
  parameter: choose_comparison {
    label: "Choose Comparison (Pivot)"
    view_label: "PoP"
    description: "Defines whether the comparison will be monthly or yearly"
    type: unquoted
    default_value: "month"
    allowed_value: {value: "year" }
    allowed_value: {value: "month"}

  }
  dimension: pop_pivot {
    view_label: "PoP"
    description: "Takes the 'choose comparison' parameter and adds a suitable parameter to it"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2 # Important
    sql:
        {% if choose_comparison._parameter_value == 'year' %} ${date_in_period_year}
        {% elsif choose_comparison._parameter_value =='month' %} ${date_in_period_month}
        {% else %}NULL{% endif %} ;;
  }

  dimension: pop_row  {
    view_label: "PoP"
    label_from_parameter: choose_breakdown
    type: string
    order_by_field: sort_by1 # Important
    sql:
        {% if choose_breakdown._parameter_value == 'day_of_month' %} ${date_in_period_day_of_month}
        {% elsif choose_breakdown._parameter_value == 'month_name' %} ${date_in_period_month_name}
        {% else %}'2022-01-01'{% endif %} ;;
  }

  dimension: days_in_period {
    hidden:  yes
    view_label: "PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), CAST({% date_end current_date_range %} AS TIMESTAMP)) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
           -- TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            TIMESTAMPADD(DAY, -${days_in_period}, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% else %}
            TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% endif %};;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
            TIMESTAMPADD(DAY, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% else %}
            TIMESTAMPADD({% parameter compare_to %}, -1, TIMESTAMPADD(DAY, -1, CAST({% date_end current_date_range %} AS TIMESTAMP)))
            {% endif %};;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${date_key_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${date_key_raw}) + 1
            WHEN ${date_key_raw} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${date_key_raw}) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension: mtd_only {
    group_label: "To-Date Filters"
    label: "MTD"
    view_label: "PoP"
    type: yesno
    sql:  (EXTRACT(DAY FROM ${date_in_period_date}) < EXTRACT(DAY FROM GETDATE())
                    OR
                (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
                    OR
                (EXTRACT(DAY FROM ${date_in_period_date}) = EXTRACT(DAY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
                EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  }
  dimension: ytd_only {
    group_label: "To-Date Filters"
    label: "YTD"
    view_label: "PoP"
    type: yesno
    sql:  (EXTRACT(DOY FROM ${date_in_period_date}) < EXTRACT(DOY FROM GETDATE())
                    OR
                (EXTRACT(DOY FROM ${date_in_period_date}) = EXTRACT(DOY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) < EXTRACT(HOUR FROM GETDATE()))
                    OR
                (EXTRACT(DOY FROM ${date_in_period_date}) = EXTRACT(DOY FROM GETDATE()) AND
                EXTRACT(HOUR FROM ${date_in_period_date}) <= EXTRACT(HOUR FROM GETDATE()) AND
                EXTRACT(MINUTE FROM ${date_in_period_date}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${date_key_raw} {% endcondition %}
                THEN 1
                WHEN ${date_key_raw} between ${period_2_start} and ${period_2_end}
                THEN 2
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }

  ## ------- HIDING FIELDS  FROM ORIGINAL VIEW FILE  -------- ##


  dimension: wtd_only {hidden:yes}


  ## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
    view_label: "PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      quarter,
      month_name,
      month_num,
      year]

  }


  dimension: period {
    view_label: "PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    hidden: yes
    order_by_field: order_for_period
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${date_key_raw} {% endcondition %}
                THEN 'This {% parameter compare_to %}'
                WHEN ${date_key_raw} between ${period_2_start} and ${period_2_end}
                THEN 'Last {% parameter compare_to %}'
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }


  ## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

  dimension: period_filtered_measures {
    hidden: yes
    description: "We just use this for the filtered measures"
    type: string
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${date_key_raw} {% endcondition %} THEN 'this'
                WHEN ${date_key_raw} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  # Filtered measures

  measure: current_period_revenue {
    view_label: "PoP"
    label: "Revenue  {{_filters['current_date_range']}} "
    type: sum
    description: "Specifies the revenue of the current period we are looking at, using the filter 'current date range' which has to be applied"
    sql: ${TABLE}.sum_of_revenue ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: current_period_margin {
    view_label: "PoP"
    label: "Margin  {{_filters['current_date_range']}} "
    type: number
    description: "Specifies the % of the net revenue out of the revenue of the current period we are looking at, using the filter 'current date range' which has to be applied"
    sql: (${current_period_revenue}-${current_period_cost})/${current_period_revenue} ;;
    value_format: "0%"


  }
  measure: previous_period_margin {
    view_label: ""
    label: " {{_filters['compare_to']}} "
    description: "Specifies the % of the net revenue out of the revenue of the previous period, using the filter 'compare to' which has to be applied"
    type: number
    sql: (${previous_period_revenue}-${previous_period_cost})/${previous_period_revenue} ;;
    value_format: "0%"


  }


  measure: margin_pop_change {
    view_label: "PoP"
    label: "Margin Previous {{_filters['compare_to']}} Change"
    description: "Specifies the change in the margin from previous period to current period, using the filter 'compare to' which has to be applied"
    type: number
    sql: CASE WHEN ${current_period_margin} = 0
                THEN NULL
                ELSE  (${current_period_margin}/${previous_period_margin})-1 END ;;
    value_format_name: percent_0
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }


  measure: previous_period_revenue{
    view_label: "PoP"
    description: "Specifies the revenue of the previous period"
    type: sum
    sql: ${TABLE}.sum_of_revenue ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: revenue_pop_change {
    view_label: ""
    label: "Rev Previous {{_filters['compare_to']}} Change"
    description: "Specifies the revenue change from the previous period to the current, using the filter 'compare to' which has to be applied"
    type: number
    sql: CASE WHEN ${current_period_revenue} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_revenue} / NULLIF(${previous_period_revenue} ,0)) - 1 END ;;
    value_format_name: percent_0
    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: current_period_cost {
    view_label: "PoP"
    type: sum
    description: "The current period's cost"
    sql: ${TABLE}.sum_of_cogs ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_cost{
    view_label: "PoP"
    type: sum
    description: "The previous period's cost"
    sql: ${TABLE}.sum_of_cogs ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: cost_pop_change {
    view_label: "PoP"
    label: "Total cost period-over-period % change"
    description: "Cost change from previous period to current"
    type: number
    sql: CASE WHEN ${current_period_revenue} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_revenue} / NULLIF(${previous_period_revenue} ,0)) - 1 END ;;
    value_format_name: percent_2

    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }


  measure: current_period_profit {
    view_label: "PoP"
    type: sum
    description: "Current period difference between revenue and cogs"
    sql: (${TABLE}.sum_of_revenue-${TABLE}.sum_of_cogs) ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }
  measure: previous_period_profit{
    view_label: "PoP"
    type: sum
    description: "Previous period difference between revenue and cogs"
    sql: (${TABLE}.sum_of_revenue-${TABLE}.sum_of_cogs) ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }

  measure: profit_pop_change {
    view_label: ""
    label: "Profit Previous {{_filters['compare_to']}} Change"
    description: "The change in the difference between revenue and cogs between previous and current periods"
    type: number
    sql: CASE WHEN ${current_period_profit} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_profit} / NULLIF(${previous_period_profit} ,0)) - 1 END ;;
    value_format_name: percent_0

    html:
    {% if value > 0 %}
    {% assign indicator = "green,▲" | split: ',' %}
    {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }


  measure: current_period_impressions {
    view_label: "PoP"
    type: sum
    description: "Current period impressions"
    sql:  ${TABLE}.sum_of_impression_pixel ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }
  measure: current_period_requests {
    view_label: "PoP"
    type: sum
    description: "Current period bid requests"
    sql:  ${TABLE}.sum_of_requests ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "this"]
  }
  measure: current_period_fill_rate {
    view_label: "PoP"
    type: number
    description: "Current period impressions/bid requests"
    sql:  (${current_period_impressions}/${current_period_requests}) ;;
    value_format: "0.00%"
    #filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_requests{
    view_label: "PoP"
    type: sum
    description: "Previous period bid requests"
    sql: ${TABLE}.sum_of_requests ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }
  measure: previous_period_impressions{
    view_label: "PoP"
    type: sum
    description: "Previous period impressions"
    sql: ${TABLE}.sum_of_impression_pixel ;;
    value_format: "$#,##0"
    filters: [period_filtered_measures: "last"]
  }
  measure: previous_period_fill_rate {
    view_label: "PoP"
    type: number
    description: "Previous period impressions/bid requests"
    sql:  (${previous_period_impressions}/${previous_period_requests}) ;;
    value_format: "0%"
    #filters: [period_filtered_measures: "this"]
  }

  measure: fill_rate__pop_change {
    view_label: ""
    label: "Previous {{_filters['compare_to']}} Change"
    type: number
    description: "Change in impressions/bid requests between previous and current periods"
    sql: (${current_period_fill_rate}/${previous_period_fill_rate})-1 ;;
    value_format_name: percent_0

    html:
      {% if value > 0 %}
      {% assign indicator = "green,▲" | split: ',' %}
      {% elsif value < 0 %}

      {% assign indicator = "red,▼" | split: ',' %}

      {% else %}

      {% assign indicator = "black,▬" | split: ',' %}

      {% endif %}
      <font color="{{indicator[0]}}">

      {% if value == 99999.12345 %} &infin

      {% else %}{{indicator[1]}}

      {% endif %}

      </font>
      {{rendered_value}}


      ;;
  }

  measure: bid_price_top_25_perc {
    label: "bid price top 25%"
    description: "Shows only bid prices that are above 0.75 of the bid floor"
    type: number
    sql: case when ${TABLE}.avg_of_dsp_bid_price>${TABLE}.avg_of_ssp_bid_floor*0.75,${TABLE}.avg_of_dsp_bid_price else null end ;;
  }

  measure: diff_bid_floor_bid_price{
    label: "diff bid floor bid price"
    description: "Shows the difference between the bid floor and the bid prices that are above 0.75 of the bid floor"
    type: number
    sql: case when ${TABLE}.avg_of_ssp_bid_floor-${TABLE}.bid_price_top_25_perc>0 then ${TABLE}.avg_of_ssp_bid_floor-${TABLE}.bid_price_top_25_perc else null end) ;;
  }

  measure: Bucket {
    label: "Bucket"
    type: count_distinct
    sql: SELECT CASE WHEN ${TABLE}.diff_bid_floor_bid_price>0 AND ${TABLE}.diff_bid_floor_bid_price<1 THEN 'under 1'
          WHEN ${TABLE}.diff_bid_floor_bid_price>=1 AND ${TABLE}.diff_bid_floor_bid_price<2 THEN '1 to 2'
          WHEN ${TABLE}.diff_bid_floor_bid_price>=2 THEN 'over 2';;
  }

  measure: count {
    type: count
    drill_fields: []
    ## hidden: yes
  }
}
