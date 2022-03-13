---@diagnostic disable: undefined-global, lowercase-global

script_name("Custom Logos")
script_authors("neverlessy")
script_version("0.5.4")

local sampev = require 'samp.events'
local imgui = require 'mimgui'
local enc = require 'encoding'
local inicfg = require 'inicfg'
local wm = require("windows.message")

local new = imgui.new
local sizeX, sizeY = getScreenResolution()
local serverName, logo
local tag = '{d12155}[Custom Logos]{ababab} '
local arrayIndexer, style = 1, 1
local posX, posY, crop, logoTransparrent, ticksUpdate = new.int(1), new.int(1), new.float(1.0), new.int(255), new.int(1)
local settingsWindow, enableWarBool, enableLogoBool, editPosition, enable = new.bool(), new.bool(), new.bool(false), new.bool(false),  new.bool()
local textdrawsIdsTemp, textdrawsXTemp, textdrawsYTemp, warIds = {}, {}, {}, {}
local serverList = {"phoenix", "tucson", "scottdale", "chandler", "brainburg", "saintrose", "mesa", "red-rock", "yuma", "surprise", "prescott", "glendale", "kingman", "winslow", "payson", "gilbert", "show-low", "casa-grande", "page"}

local mainIni = inicfg.load({
      settings =
      {
          enableLogoBool = true,
          enableWarBool = false,
          logoTransparrent = 55,
          ticksUpdate = 1,
          posX = 500,
          posY = 500,
          crop = 1.0
      }
  })

local iniDirectory = "CustomLogos.ini"
local iniMain = inicfg.load(mainIni, iniDirectory)
local iniState = inicfg.save(iniMain, iniDirectory)

enc.default = 'CP1251'
local u8 = enc.UTF8

imgui.OnInitialize(function()
    styleInit()
    imgui.GetIO().IniFilename = nil
end)

local settings = imgui.OnFrame(
    function() return settingsWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(370, 200), imgui.Cond.FirstUseEver)
        imgui.Begin("������� � ������ �� ��� �������. ���� � ������ ������� � ���� �����.", settingsWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
        if imgui.Checkbox(u8'�������� ������', enable) then
          if enable[0] then
            for i = 1, #textdrawsIdsTemp do
              sampTextdrawSetPos(textdrawsIdsTemp[i], 9999.1, 0)
            end
          else
            for i = 1, #textdrawsIdsTemp do
              sampTextdrawSetPos(textdrawsIdsTemp[i], textdrawsXTemp[i], textdrawsYTemp[i])
            end
          end
        end imgui.SameLine() imgui.TextQuestion("( ? )", u8"�������� ��� ��������� ����������� ��������")
        imgui.Checkbox(u8'����� �����', enableWarBool) imgui.SameLine() imgui.TextQuestion("( ? )", u8"�������� ��� ��������� ����������� ������ ������, ��� ������ ������� � ������. ����� ��������� ���������� ���������������� � �������")
        imgui.SliderInt(u8"������������", logoTransparrent, 0, 255) imgui.SameLine() imgui.TextQuestion("( ? )", u8"�������� ������������ ��������")
        imgui.SliderInt(u8"������", ticksUpdate, 1, 30) imgui.SameLine() imgui.TextQuestion("( ? )", u8"�������� ������� ��������. ��� ������ �������� - ��� ���� ������������������ �������. ��������� �������� �� ��� ���, ���� ����� �� ����� ������������, ��� ��� ������� �� ����� �������.")
        imgui.SliderFloat(u8"���������", crop, 0.1, 10.0) imgui.SameLine() imgui.TextQuestion("( ? )", u8"���������������� ���������� ��� ��������� ������� ��������")
        if imgui.Button(u8"�������", imgui.ImVec2(240, 30)) then
            editPosition[0]= true
            sampAddChatMessage(tag..'����� ��������� �������, ������� {d12155}������', -1)
        end imgui.SameLine() imgui.TextQuestion("( ? )", u8"�������� ������� ��������")
        if imgui.Button(u8"���������", imgui.ImVec2(240, 30)) then
            iniMain.settings.posX = posX[0]
            iniMain.settings.posY = posY[0]
            iniMain.settings.crop = crop[0]
            iniMain.settings.logoTransparrent = logoTransparrent[0]
            iniMain.settings.ticksUpdate = ticksUpdate[0]
            iniMain.settings.enableWarBool = enableWarBool[0]
            iniMain.settings.enable = enable[0]
           if inicfg.save(iniMain, iniDirectory) then
                sampAddChatMessage(tag..'��������� ������� {65c29e}���������', -1)
           else
                sampAddChatMessage(tag..'��� ���������� ��������� {d12155}������', -1)
           end
        end imgui.SameLine() imgui.TextQuestion("( ? )", u8"��������� ������� ���������")
        imgui.End()
        player.HideCursor = false
    end
)

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(0) end
    sampAddChatMessage(tag..'�����: {d12155}neverlessy', -1)
    sampAddChatMessage(tag..'������� ������: {d12155}'..thisScript().version, -1)
    autoupdate("https://raw.githubusercontent.com/neverlessy/custom-logos/master/autoupdate.json", '['..string.upper(thisScript().name)..']: ', "https://www.blast.hk/threads/60462/")
    sampRegisterChatCommand('logo', function()
        settingsWindow[0] = not settingsWindow[0]
    end)
    logoTransparrent[0] = mainIni.settings.logoTransparrent
    posX[0] = mainIni.settings.posX
    posY[0] = mainIni.settings.posY
    crop[0] = iniMain.settings.crop
    ticksUpdate[0] = iniMain.settings.ticksUpdate
    enableWarBool[0] = iniMain.settings.enableWarBool
    enable[0] = iniMain.settings.enable
    while not sampIsPlayerConnected() do wait(0) end
    for i = 1, 19 do
      if string.lower(sampGetCurrentServerName()):match(serverList[i]) then
        serverName = serverList[i]
        logo = renderLoadTextureFromFile(getWorkingDirectory().."/resource/CustomLogos/img/"..style.."/"..serverName..".png")
        enable[0] = true
        sampAddChatMessage(tag..'������������ ������� �������{d12155} '..string.upper(serverList[i]), -1)
      end
    end
    downloadImage()
    addEventHandler("onWindowMessage", function(msg, wparam, lparam)
		if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
				if wparam == 27 then
						if settingsWindow[0] then
								consumeWindowMessage()
								settingsWindow[0] = not settingsWindow[0]
						end
				end
		end
	end)
    while true do wait(ticksUpdate[0])
        if enable[0] then
            if editPosition[0] then
                posX[0], posY[0] = getCursorPos()
                renderDrawTexture(logo, posX[0] - (180 * crop[0]), posY[0] - (60 * crop[0]), 360.0 * crop[0], 105.0 * crop[0], 0, string.format("0x%xFFFFFF", logoTransparrent[0]))
                if isKeyJustPressed(32) then
                    editPosition[0] = false
                    posX[0] = posX[0] - (180 * crop[0])
                    posY[0] = posY[0] - (60 * crop[0])
                    sampAddChatMessage(tag..'������� ������� {65c29e}���������', -1)
                end
            else
                renderDrawTexture(logo, posX[0], posY[0], 360.0 * crop[0], 105.0 * crop[0], 0, string.format("0x%xFFFFFF", logoTransparrent[0]))
            end
        end
    end
end

function sampev.onShowTextDraw(id, data)
    pX = math.modf(data.position.x)
    pY = math.modf(data.position.y)
    if (pX == 550 and pY == 1) or (pX == 565 and pY == 6) or (pX == 563 and pY == 14) or (pX == 526 and pY == 4) or (pX == 539 and pY == 7) or (pX == 539 and pY == 15) then
      textdrawsIdsTemp[arrayIndexer] = id
      textdrawsXTemp[arrayIndexer] = data.position.x
      textdrawsYTemp[arrayIndexer] = data.position.y
      arrayIndexer = arrayIndexer + 1
      if enable[0] then
          data.position.x = 99999.1
      end
    end
    if (pX == 606 and pY == 3) or (pX == 609 and pY == 6) or (pX == 600 and pY == 13) or (pX == 616 and pY == 21) or (pX == 619 and pY == 16) or (pX == 619 and pY == 13) or (pX == 616 and pY == 7) or (pX == 611 and pY == 8) or (pX == 600 and pY == 16) then
      if enableWarBool[0] == false then
        return false
      end
    end
    return { id, data }
end

function unloadScript(reason)
    if reason ~= nil then
        sampAddChatMessage(tag..'������ �������� ���� ������ �� �������:{d12155} '..reason, -1)
        thisScript():unload()
    end
end

function downloadImage()
    if not doesFileExist(getWorkingDirectory() .. '/resource/CustomLogos/img/'..style..'/'..serverName..'.png') then
        local url = 'https://raw.githubusercontent.com/neverlessy/custom-logos/master/img/'..style..'/'..serverName..'.png'
        download_id = downloadUrlToFile(url, getWorkingDirectory() .. '/resource/CustomLogos/img/'..style..'/'..serverName..'.png', download_handler)
    end
end

function download_handler(id, status, p1, p2)
    if stop_downloading then
      stop_downloading = false
      download_id = nil
      print('�������� ��������.')
      sampAddChatMessage(tag..'��������{d12155} ��������' -1)
      return false
    end
end

function autoupdate(json_url, tag, url)
    local dlstatus = require('moonloader').download_status
    local tag = '{d12155}[Custom Logos]{ababab} '
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
                lua_thread.create(function(tag)
                  local dlstatus = require('moonloader').download_status
                  local color = -1
                  sampAddChatMessage((tag..'���������� ����������. ������� ������:{d12155} '..thisScript().version..' {ababab}| ����� ������:{65c29e} '..updateversion), color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('��������� %d �� %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                                              print('�������� ���������� ���������.')
                                              sampAddChatMessage((tag..'���������� ���������!'), color)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((tag..'���������� ������ ��������. �������� ���������� ������..'), color)
                          update = false
                        end
                      end
                    end
                  )
                  end, tag
                )
              else
                update = false
                print('v'..thisScript().version..': ���������� �� ���������.')
              end
            end
          else
            print('v'..thisScript().version..': �� ���� ��������� ����������. ���������� ����� ��� ��������� ������� �� '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function styleInit()
    local style = imgui.GetStyle()
      local colors = style.Colors
      local clr = imgui.Col
      local ImVec4 = imgui.ImVec4
  
      style.Alpha = 1.0
      style.ChildRounding = 3.0
      style.WindowRounding = 8.0
      style.GrabRounding = 4.0
      style.GrabMinSize = 20.0
      style.FrameRounding = 3.0
  
      colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00);
      colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00);
      colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00);
      colors[clr.ChildBg] = ImVec4(0.07, 0.07, 0.09, 1.00);
      colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00);
      --colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88);
      colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00);
      colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00);
      colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75);
      colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00);
      colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31);
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      --colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00);
      colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31);
      colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31);
      colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00);
      colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00);
      colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      --colors[clr.Column] = ImVec4(0.56, 0.56, 0.58, 1.00);
      --colors[clr.ColumnHovered] = ImVec4(0.24, 0.23, 0.29, 1.00);
      --colors[clr.ColumnActive] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00);
      colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00);
      colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
      --colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16);
      --colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39);
      --colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00);
      colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63);
      colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00);
      colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63);
      colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00);
      colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43);
      --colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73);
  end