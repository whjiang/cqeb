-- helper.lua
-- List features and usage of the schema.

local function translator(input, seg,env)
	local composition = env.engine.context.composition
	local segment = composition:back()
	if input==rv_var.help then
		local table = {
			{ '时间输出',''..rv_var.date_var .. '｜' .. rv_var.time_var.. '｜' .. rv_var.week_var}
			, { '历法节气',''..rv_var.nl_var .. '｜' .. rv_var.jq_var}
			, { '农历反查', '任意大写字母引导+数字日期' }
			, { '功能切换',''..rv_var.switch_keyword }
			, { '方案切换',''..rv_var.switch_schema }
			, { '繁简切换', 'Ctrl + Shift + F' }
			, { 'Emoji开关', 'Ctrl + Shift + G' }
			, { '显隐编码', 'Ctrl + Shift + H' }
			, { '显隐拼音', 'Ctrl + Shift + J' }
			, { '单字模式', 'Ctrl + Shift + k' }
			, { '金额大写', '任意大写字母引导+数字' }
			, { '临时拼音', 'i 键引导临时拼音及形码' }
			, { '重复历史', 'uj 重复历史' }
			, { '精准造词', '` 键引导精准造词' }
			, { '选单', 'Ctrl+` 或 F4' }
			, { 'lua字符串', '以大写字母开头触发' }
			, { '帮助', ''..rv_var.help }
			, { '官方网盘', 'http://fds8866.ys168.com' }
			, { '博客', 'https://liangbi.gitee.io' }
			, { 'QQ群', '715024083' }
		}
		segment.prompt ='简要说明'
		for k, v in ipairs(table) do
			local cand = Candidate('help', seg.start, seg._end, v[1], ' ' .. v[2])
			-- cand.preedit = input .. '\t简要说明'
			-- cand.quality=100000000
			yield(cand)
		end
	end
end

return translator
