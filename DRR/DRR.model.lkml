connection: "vertica_iad"

include: "/**/*.view.lkml"                 # include all views in this project

explore: DRR {
  view_name: drr
}

explore: DRR_Legacy {
  view_name: drr_legacy
}
