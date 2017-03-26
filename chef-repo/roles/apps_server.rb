name "apps_server"
description "Role applied to the system that should run all of the Fonoster's apps."
run_list ["fn_commons::default", "fn_commons::users", "fn_commons::config", "fn_astive", "fn_sipio", "fn_jetty"]

