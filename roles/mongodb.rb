name "mongodb"
description "Role applied to the system that should run MongoDB."
run_list ["fn_commons::users", "fn_mongodb"]
