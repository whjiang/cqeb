local function commit_text_processor(key, env)
	local engine = env.engine
	local context = engine.context
	local composition = context.composition
	local segment = composition:back()
	local input_text = context.input
	if input_text:find("^(%l+)$") then
		local candidate_count = segment.menu:candidate_count()
		env.last_1th_text=context:get_commit_text() or ""
		if candidate_count>1 then
			env.last_2th_text=segment:get_candidate_at(1).text
			if candidate_count>2 then env.last_3th_text=segment:get_candidate_at(2).text else env.last_3th_text="" end
		end
	end
	if key.keycode==0x27 and context:is_composing() and env.last_3th_text~="" then
		context:clear()
		engine:commit_text(env.last_3th_text)
		return 1
	end
	local m,n=input_text:find("^(%l+)([%[%/%]\\])")
	if n~=nil and m~=nil then
		if (context:is_composing()) then
			-- local focus_text = context:get_commit_text()
			-- engine:commit_text(focus_text)
			context:clear()
			engine:commit_text(env.last_1th_text..CandidateText[1])  -- 第1个候选标点符号
			return 1
		end
	end
	return 2
end

return commit_text_processor