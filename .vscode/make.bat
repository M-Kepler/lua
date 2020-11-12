set lua_path=%1
set "lua_path=%lua_path:\=/%"
bash -c "time lua %lua_path%"