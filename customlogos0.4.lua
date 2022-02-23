script_name("Custom Logos")
script_authors("neverlessy")
script_version("0.4.4")
require "lib.moonloader"

local encoding = require 'encoding'
local servers = {"phoenix", "tucson", "scottdale", "chandler", "brainburg", "saintrose", "mesa", "redrock", "yuma", "surprise", "prescott", "glendale", "kingman", "winslow", "payson", "gilbert", "showlow", "casagrande", "page"}
local logos = {}
encoding.default = 'CP1251'

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then
        return
    end
    while not isSampAvailable() do
        wait(0)
    end
		autoupdate("https://raw.githubusercontent.com/neverlessy/custom-logos/master/autoupdate.json", '['..string.upper(thisScript().name)..']: ', "https://www.blast.hk/threads/60462/")
		adress,  port = sampGetCurrentServerAddress()
		server = string.format('%s:%s', adress, port)
		sampAddChatMessage("{CC8C51}[Custom Logos] {d5dedd}Скрипт активирован. Автор: {CC8C51}hijuce.", 0x01A0E9)
		sampRegisterChatCommand("logos", ScriptInfo)
		LoadImage()
		loadLogoToGame()
		loadLogoToScreen()
    wait(-1)
end

function loadLogoToGame()
	for i = 1, 19 do
		wait(5)
		logos[i] = renderLoadTextureFromFile('moonloader/img/'..tostring(servers[i])..".png")
	end
end

function loadLogoToScreen()
	userscreenX, userscreenY = getScreenResolution()
	local posX = userscreenX - 310
	local posY = (userscreenY - userscreenY) + 1
	while true do
		wait(0)
		if server == '185.169.134.3:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[1], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.4:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[2], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.43:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[3], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.44:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[4], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.45:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[5], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.5:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[6], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.59:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[7], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.61:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[8], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.107:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[9], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.109:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[10], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.166:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[11], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.171:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[12], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.172:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[13], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.173:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[14], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '185.169.134.174:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[15], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '80.66.82.191:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[16], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '80.66.82.190:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[17], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '80.66.82.188:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[18], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
		if server == '80.66.82.168:7777' then
			while true do
				wait(0)
				deltd()
				renderDrawTexture(logos[19], posX, posY, 360, 105, 0, 0xFFFFFFFF)
			end
		end
	end
end

function deltd()
		sampTextdrawDelete(532)
		sampTextdrawDelete(533)
		sampTextdrawDelete(534)
end

function ScriptInfo()
	sampShowDialog(1999, "{CC8C51}[Custom Logos] {ffffff}> Информация", "{CC8C51}Custom Logos {FFFFFF}- это LUA скрипт на собственные логотипы для популярных серверов\n{CC8C51}Версия скрипта {FFFFFF}: {ffffff}0.3{FFFFFF}\n\nНа данный момент нарисованы логотипы для таких серверов, как\n\n{ffffff}> {CC8C51}Arizona \n{549f68}Phoenix {CC8C51}{CC8C51}|{549f68}{549f68} Saint-Rose {CC8C51}{CC8C51}|{549f68}{549f68} Tucson {CC8C51}{CC8C51}|{549f68}{549f68} Scottdale {CC8C51}|{549f68} Chandler {CC8C51}|{549f68} Brainburg {CC8C51}|{549f68} Mesa {CC8C51}|{549f68} Red-Rock {CC8C51}|{549f68} Yuma\nSurprice {CC8C51}|{549f68} Prescott {CC8C51}|{549f68} Glendale {CC8C51}|{549f68} Kingman {CC8C51}|{549f68} Winslow {CC8C51}|{549f68} Payson {CC8C51}|{549f68} Gilbert {CC8C51}|{549f68} Show-Low {CC8C51}|{549f68} Casa Grande {CC8C51}|{549f68} Page","Закрыть")
end

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
	local prefix = '{CC8C51}[Custom Logos] {d5dedd}'
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Текущая версия:{629eee} '..thisScript().version..' {CC8C51}|{d5dedd} Новая версия:{629eee} '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
											print('Загрузка обновления завершена.')
											sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Попробуйте позже или проверьте наличие на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end

function download_handler(id, status, p1, p2)
  if stop_downloading then
    stop_downloading = false
    download_id = nil
    print('Загрузка отменена.')
    return false
  end
end

function LoadImage()
	sampAddChatMessage("{CC8C51}[Custom Logos] {d5dedd}Загрузка логотипов...", 0x01A0E9)
	createDirectory("moonloader/resource/CustomLogos/img")
	for i = 1, 19 do
		wait(5)
		if not doesFileExist(getWorkingDirectory() .. '/resource/CustomLogos/img/'..tostring(servers[i])..'.png') then
			local url = 'https://raw.githubusercontent.com/neverlessy/custom-logos/master/img/'..tostring(servers[i])..'.png'
			download_id = downloadUrlToFile(url, getWorkingDirectory() .. '/resource/CustomLogos/img/'..tostring(servers[i])..'.png', download_handler)
		end
	end
end
