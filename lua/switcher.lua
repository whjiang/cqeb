--[[
switch_keyword关键字更换在rime.lua文件rv_var中
须将 lua_processor@switch_processor 放在 engine/processors 里，并位于默认 selector 之前
--]]

-- 帮助函数，返回被选中的候选的索引
local function select_index(key, env)
	local ch = key.keycode
	local index = -1
	local select_keys = env.engine.schema.select_keys
	if select_keys ~= nil and select_keys ~= "" and not key.ctrl() and ch >= 0x20 and ch < 0x7f then
		local pos = string.find(select_keys, string.char(ch))
		if pos ~= nil then index = pos end
	elseif ch >= 0x30 and ch <= 0x39 then
		index = (ch - 0x30 + 9) % 10
	elseif ch >= 0xffb0 and ch < 0xffb9 then
		index = (ch - 0xffb0 + 9) % 10
	elseif ch == 0x20 then
		index = 0
	end
	return index
end

-- 切换开关函数
local function apply_switch(env, keyword, target_state)
	local context = env.engine.context
	local switcher = env.switcher
	local config = switcher.user_config
	context:set_option(keyword, target_state)
	-- 如果设置了自动保存，则需相应的配置
	if switcher:is_auto_save(keyword) and config ~= nil then
		config:set_bool("var/option/" .. keyword, target_state)
		-- switcher:refresh_menu(keyword)
	end
end

local kRejected = 0
local kAccepted = 1
local kNoop = 2
local switches_keyword1="zh_trad"
local switches_keyword2="new_spelling"

local function get_switches_list(key, env)
	local config =env.engine.schema.config
	local size=config:get_list_size("switches")
	local switches_list={}
	for i =1, size do
		table.insert(switches_list,{config:get_string("switches/@" .. i-1 .. "/name"),config:get_string("switches/@" .. i .. "/reset")})
	end
	return switches_list
end

local function get_switch_states(list,name)
	if type(list)~="table" then return "" end
	for i =1, #list do
		if list[i][1]==name then return list[i][2] end
	end
	return ""
end

local function IsExistChar(obj,chars)
	if type(obj)~="table" or chars=="" then return "" end
	for i =1,#obj do
		if obj[i][2]==chars then return obj[i][1] end
	end
	return ""
end

local function selector(key, env)
	if env.switcher == nil then return kNoop end
	if key:release() or key:alt() then return kNoop end
	local context = env.engine.context
	local cand=nil
	-- if key:repr() =="Control+1" then
	-- 	env.engine:apply_schema(Schema("wubi98_S"))
	-- 	context:clear()
	-- 	return kAccepted
	-- end
	if (context:is_composing()) then
		local idx = select_index(key,env)
		if idx < 0 then return kNoop end
		-- local focus_text = context:get_commit_text()
		local composition = context.composition
		local segment = composition:back()
		local candidate_count = segment.menu:candidate_count()    -- segment:get_candidate_at(2)
		-- if candidate_count<1 then return kNoop end
		local selected_candidate=segment:get_selected_candidate() or ""
		if candidate_count>idx then cand=segment:get_candidate_at(idx).text end
		if cand==nil then return kNoop end
		if context.input == rv_var.switch_keyword and selected_candidate.text:find("⇉") or context.input == rv_var.switch_keyword and cand:find("⇉") then
			local state1 = nil
			local state2 = nil
			if selected_candidate.text:find("^简") and cand:find("^简") or selected_candidate.text:find("^簡") and cand:find("^簡") then
				state1 = true
				-- env.engine:commit_text(segment:get_candidate_at(2).text..cand..idx)
			elseif selected_candidate.text:find("^繁") or cand:find("^繁") then
				state1 = false
				-- env.engine:commit_text(selected_candidate.text..cand..1)
			elseif selected_candidate.text~=cand and selected_candidate.text:find("方案") or selected_candidate.text~=cand and cand:find("方案") then
				-- env.engine:commit_text(selected_candidate.text..12)
				-- env.engine:apply_schema(Schema("wubi98_U"))    -- enable_schema_list启用的方案列表table
				env.switcher:select_next_schema()
				context:clear()
				return kAccepted
			elseif selected_candidate.text~=cand and selected_candidate.text:find("拆分") or selected_candidate.text~=cand and cand:find("拆分") then
				-- env.engine:commit_text(selected_candidate.text..11)
				if selected_candidate.text:find("开") or cand:find("开") or selected_candidate.text:find("開") or cand:find("開") then
					state2 = true
				elseif selected_candidate.text:find("关") or cand:find("关") or selected_candidate.text:find("關") or cand:find("關") then
					state2 = false
				end
			end
			if state1 ~= nil then
				apply_switch(env, switches_keyword1, state1)
				context:clear()
				return kAccepted
			elseif state2 ~= nil then
				apply_switch(env, switches_keyword2, state2)
				context:clear()
				return kAccepted
			end
		elseif context.input == rv_var.switch_schema then
			local sc1= IsExistChar(enable_schema_list,selected_candidate.text)
			local sc2= IsExistChar(enable_schema_list,cand)
			if sc1~="" and sc2~="" then
				if sc1==sc2 and enable_schema_list[1][1]==sc1 or sc1~=sc2 and enable_schema_list[1][1]==sc2 then
					local schema= Schema(sc1)
					-- env.engine:commit_text(sc1.."111")
					-- context:clear()
					env.engine:apply_schema(schema)
					return kAccepted
				else
					local schema= Schema(sc2)
					-- env.engine:commit_text(sc2.."222")
					-- context:clear()
					env.engine:apply_schema(schema)
					return kAccepted
				end
			end
		end
	end
	return kNoop
end

-- 初始化 switcher
local function init(env)
	-- 若当前 librime-lua 版本未集成 Switcher 则无事发生
	if Switcher == nil then return end
	env.switcher = Switcher(env.engine)
	page_size = env.engine.schema.page_size
end

return { init = init, func = selector }