connection: "vertica_iad"

include: "/**/*.view.lkml"                 # include all views in this project

explore: DRR {
  view_name: drr
  # sql_always_where: ${drr.Event_Date_Dt} = {% parameter drr.Report_Run_Date %} ;;
}
