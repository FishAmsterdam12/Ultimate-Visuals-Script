local core_gui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
    core_gui = (gethui and gethui()) or game:GetService("CoreGui")
end)

local run_service = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local http = game:GetService("HttpService")
local uis = game:GetService("UserInputService")

local dict = {
    ru = {
        w_name = "Мир",
        c_name = "Камера И Небо",
        f_name = "Эффекты",
        p_name = "Пресеты",
        cfg_name = "Конфиги",
        s_name = "Настройки",
        map_col = "Цвет Карты",
        map_mat = "Материал Карты",
        orig = "Оригинал",
        res_map = "Сбросить Цвет И Материал",
        fov = "Угол Обзора (FOV)",
        res_fov = "Сбросить FOV",
        sky_list = "Готовые Скайбоксы",
        sky_id = "Кастомный ID Неба",
        res_sky = "Сбросить Небо (Оригинал)",
        t_cycle = "Автосмена Времени",
        time = "Время Суток",
        res_time = "Сбросить Время",
        shadows = "Тени",
        bright = "Яркость Мира",
        res_light = "Сбросить Яркость И Тени",
        fog = "Туман",
        f_col = "Цвет Тумана",
        f_end = "Дальность (Fog End)",
        f_start = "Начало (Fog Start)",
        res_fog = "Сбросить Туман",
        tint = "Включить Оттенок",
        t_col = "Цвет Оттенка",
        t_trans = "Прозрачность",
        res_tint = "Сбросить Оттенок",
        save = "Сохранить Конфиг",
        load = "Загрузить Конфиг",
        upd = "Обновить Список",
        copy_path = "Скопировать Путь К Папке Конфигов",
        h_reset = "Полный Сброс (Хард Ресет)",
        unload = "Выгрузить Меню",
        blur_tgl = "Включить Blur",
        blur_sz = "Сила Размытия",
        sun_tgl = "Включить SunRays",
        sun_int = "Интенсивность Лучей",
        sun_spr = "Размах Лучей",
        dof_tgl = "Включить DepthOfField",
        dof_rad = "Радиус Фокуса",
        bloom_tgl = "Включить Bloom",
        bloom_int = "Bloom Интенсивность",
        cc_tgl = "Включить Цветокор",
        cc_sat = "Насыщенность",
        cc_con = "Контраст",
        res_preset = "Сбросить Пресеты",
        enter_name = "Введи Название",
        enter_id = "ID",
        cfg_list = "Список Конфигов",
        scr_mode = "Screenshot Mode (Прячет UI На 3 Сек)",
        change_lang = "Сменить Язык (Сохраняет Настройки)",
        name_input = "Имя"
    },
    en = {
        w_name = "World",
        c_name = "Camera And Sky",
        f_name = "Effects",
        p_name = "Presets",
        cfg_name = "Configs",
        s_name = "Settings",
        map_col = "Map Color",
        map_mat = "Map Material",
        orig = "Original",
        res_map = "Reset Color And Material",
        fov = "Field Of View (FOV)",
        res_fov = "Reset FOV",
        sky_list = "Ready Skyboxes",
        sky_id = "Custom Sky ID",
        res_sky = "Reset Sky (Original)",
        t_cycle = "Time Cycle",
        time = "Clock Time",
        res_time = "Reset Time",
        shadows = "Shadows",
        bright = "World Brightness",
        res_light = "Reset Brightness And Shadows",
        fog = "Fog",
        f_col = "Fog Color",
        f_end = "Distance (Fog End)",
        f_start = "Start (Fog Start)",
        res_fog = "Reset Fog",
        tint = "Enable Tint",
        t_col = "Tint Color",
        t_trans = "Transparency",
        res_tint = "Reset Tint",
        save = "Save Config",
        load = "Load Config",
        upd = "Refresh List",
        copy_path = "Copy Config Folder Path",
        h_reset = "Full Reset (Hard Reset)",
        unload = "Unload Menu",
        blur_tgl = "Enable Blur",
        blur_sz = "Blur Strength",
        sun_tgl = "Enable SunRays",
        sun_int = "Rays Intensity",
        sun_spr = "Rays Spread",
        dof_tgl = "Enable DepthOfField",
        dof_rad = "Focus Radius",
        bloom_tgl = "Enable Bloom",
        bloom_int = "Bloom Intensity",
        cc_tgl = "Enable Color Correction",
        cc_sat = "Saturation",
        cc_con = "Contrast",
        res_preset = "Reset Presets",
        enter_name = "Enter Name",
        enter_id = "ID",
        cfg_list = "Config List",
        scr_mode = "Screenshot Mode (Hides UI for 3 Sec)",
        change_lang = "Change Language (Keeps Settings)",
        name_input = "Name"
    },
    no = {
        w_name = "Verden",
        c_name = "Kamera Og Himmel",
        f_name = "Effekter",
        p_name = "Forhåndsinnstillinger",
        cfg_name = "Konfigurasjoner",
        s_name = "Innstillinger",
        map_col = "Kartfarge",
        map_mat = "Kartmateriale",
        orig = "Original",
        res_map = "Tilbakestill Farge Og Materiale",
        fov = "Synsfelt (FOV)",
        res_fov = "Tilbakestill FOV",
        sky_list = "Ferdige Himmeler",
        sky_id = "Egendefinert Himmel ID",
        res_sky = "Tilbakestill Himmel",
        t_cycle = "Tidssyklus",
        time = "Klokkeslett",
        res_time = "Tilbakestill Tid",
        shadows = "Skygger",
        bright = "Verdens Lysstyrke",
        res_light = "Tilbakestill Lys Og Skygger",
        fog = "Tåke",
        f_col = "Tåkefarge",
        f_end = "Avstand (Fog End)",
        f_start = "Start (Fog Start)",
        res_fog = "Tilbakestill Tåke",
        tint = "Aktiver Fargetone",
        t_col = "Fargetone",
        t_trans = "Gjennomsiktighet",
        res_tint = "Tilbakestill Fargetone",
        save = "Lagre Konfig",
        load = "Last Inn Konfig",
        upd = "Oppdater Liste",
        copy_path = "Kopier Konfig Mappe Bane",
        h_reset = "Full Tilbakestilling",
        unload = "Fjern Meny",
        blur_tgl = "Aktiver Blur",
        blur_sz = "Blur Styrke",
        sun_tgl = "Aktiver SunRays",
        sun_int = "Solstråle Intensitet",
        sun_spr = "Solstråle Spredning",
        dof_tgl = "Aktiver DepthOfField",
        dof_rad = "Fokusradius",
        bloom_tgl = "Aktiver Bloom",
        bloom_int = "Bloom Intensitet",
        cc_tgl = "Aktiver Fargekorrigering",
        cc_sat = "Metning",
        cc_con = "Kontrast",
        res_preset = "Tilbakestill Forhåndsinnstillinger",
        enter_name = "Skriv Navn",
        enter_id = "ID",
        cfg_list = "Konfigurasjonsliste",
        scr_mode = "Skjermbilde Modus (Skjuler UI i 3 Sek)",
        change_lang = "Bytt Språk (Beholder Innstillinger)",
        name_input = "Navn"
    }
}

local original_props = {}
local original_lighting = {
    Ambient = lighting.Ambient,
    OutdoorAmbient = lighting.OutdoorAmbient,
    Brightness = lighting.Brightness,
    ClockTime = lighting.ClockTime,
    FogEnd = lighting.FogEnd,
    FogStart = lighting.FogStart,
    FogColor = lighting.FogColor,
    GlobalShadows = lighting.GlobalShadows,
}

local def_fog_end = math.clamp(original_lighting.FogEnd, 0, 3000)
local def_fog_start = math.clamp(original_lighting.FogStart, 0, 1000)
local def_brightness = math.clamp(original_lighting.Brightness, 0, 10)
local def_clock = math.clamp(original_lighting.ClockTime, 0, 24)

local original_sky = nil
pcall(function()
    for _, obj in ipairs(lighting:GetChildren()) do
        if obj:IsA("Sky") then
            original_sky = obj:Clone()
            break
        end
    end
end)

local created_effects = {}
local flags = {}
local loop_tickets = {color = 0, mat = 0, reset = 0}

local config_state = {
    map_color = {r = 1, g = 1, b = 1},
    map_material = {"Оригинал"},
    fov_slider = 70,
    time_cycle = false,
    clock_time = def_clock,
    shadows = true,
    brightness = def_brightness,
    fog_color = {
        r = original_lighting.FogColor.R,
        g = original_lighting.FogColor.G,
        b = original_lighting.FogColor.B
    },
    fog_end = def_fog_end,
    fog_start = def_fog_start,
    tint_tgl = false,
    tint_color = {r = 1, g = 0, b = 0},
    tint_trans = 50,
    blur_tgl = false,
    blur_size = 10,
    sun_tgl = false,
    sun_int = 0.25,
    sun_spread = 1,
    dof_tgl = false,
    dof_radius = 10,
    bloom_tgl = false,
    bloom_int = 1,
    cc_tgl = false,
    cc_sat = 0,
    cc_con = 0,
    custom_sky = ""
}

local tint_gui = core_gui:FindFirstChild("ult_tint_gui")
if not tint_gui then
    pcall(function()
        tint_gui = Instance.new("ScreenGui")
        tint_gui.Name = "ult_tint_gui"
        tint_gui.IgnoreGuiInset = true
        tint_gui.Enabled = false
        tint_gui.Parent = core_gui
        
        local t_frame = Instance.new("Frame")
        t_frame.Name = "tint_frame"
        t_frame.Size = UDim2.new(1, 0, 1, 0)
        t_frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        t_frame.BackgroundTransparency = 0.5
        t_frame.BorderSizePixel = 0
        t_frame.Parent = tint_gui
    end)
end
local tint_frame = tint_gui and tint_gui:FindFirstChild("tint_frame")

local rayfield_lib = nil

local function notify(text)
    pcall(function()
        if rayfield_lib then
            rayfield_lib:Notify({
                Title = "Инфо",
                Content = text,
                Duration = 3
            })
        end
    end)
end

local function get_effect(class_name)
    if not created_effects[class_name] or not created_effects[class_name].Parent then
        local eff = lighting:FindFirstChildWhichIsA(class_name)
        if not eff then
            pcall(function()
                eff = Instance.new(class_name)
                eff.Parent = lighting
            end)
        end
        created_effects[class_name] = eff
    end
    return created_effects[class_name]
end

local function disable_atmosphere()
    pcall(function()
        for _, obj in ipairs(lighting:GetChildren()) do
            if obj:IsA("Atmosphere") then
                obj.Enabled = false
            end
        end
    end)
end

local function apply_skybox(id_num)
    if not id_num or id_num == "" then return end
    pcall(function()
        local final_id = "rbxassetid://" .. id_num
        for _, obj in ipairs(lighting:GetChildren()) do
            if obj:IsA("Sky") then
                obj:Destroy()
            end
        end
        local new_sky = Instance.new("Sky")
        new_sky.SkyboxBk = final_id
        new_sky.SkyboxDn = final_id
        new_sky.SkyboxFt = final_id
        new_sky.SkyboxLf = final_id
        new_sky.SkyboxRt = final_id
        new_sky.SkyboxUp = final_id
        new_sky.Parent = lighting
    end)
end

local function reset_sky()
    pcall(function()
        config_state.custom_sky = ""
        for _, obj in ipairs(lighting:GetChildren()) do
            if obj:IsA("Sky") then
                obj:Destroy()
            end
        end
        if original_sky then
            original_sky:Clone().Parent = lighting
        end
    end)
end

local function clear_presets()
    pcall(function()
        lighting.Ambient = original_lighting.Ambient
        lighting.OutdoorAmbient = original_lighting.OutdoorAmbient
        lighting.FogEnd = original_lighting.FogEnd
        lighting.FogStart = original_lighting.FogStart
        lighting.FogColor = original_lighting.FogColor
        
        local cc = lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
        if cc then
            cc.Enabled = false
            cc.TintColor = Color3.fromRGB(255, 255, 255)
            cc.Saturation = 0
            cc.Contrast = 0
        end
        
        for _, class in ipairs({"BlurEffect", "BloomEffect", "SunRaysEffect", "DepthOfFieldEffect", "Atmosphere"}) do
            local fx = lighting:FindFirstChildWhichIsA(class)
            if fx then
                fx.Enabled = false
            end
        end
    end)
end

local function save_original(obj)
    if not original_props[obj] then
        original_props[obj] = {Color = obj.Color, Material = obj.Material}
    end
end

local function safe_set(flag, value)
    if flag then
        pcall(function()
            flag:Set(value)
        end)
    end
end

local function is_original_mat(val)
    return val == dict.ru.orig or val == dict.en.orig or val == dict.no.orig
end

local time_cycle_conn

local function reset_all(l)
    pcall(function()
        clear_presets()
        reset_sky()
        
        for name, flag in pairs(flags) do
            if name:match("_tgl$") or name == "time_cycle" then
                safe_set(flag, false)
            end
        end
        
        safe_set(flags.fov_slider, 70)
        safe_set(flags.clock_time, def_clock)
        safe_set(flags.shadows, original_lighting.GlobalShadows)
        safe_set(flags.brightness, def_brightness)
        safe_set(flags.fog_end, def_fog_end)
        safe_set(flags.fog_start, def_fog_start)
        safe_set(flags.fog_color, original_lighting.FogColor)
        safe_set(flags.tint_color, Color3.fromRGB(255, 0, 0))
        safe_set(flags.map_color, Color3.fromRGB(255, 255, 255))
        
        safe_set(flags.blur_size, 10)
        safe_set(flags.sun_int, 0.25)
        safe_set(flags.sun_spread, 1)
        safe_set(flags.dof_radius, 10)
        safe_set(flags.bloom_int, 1)
        safe_set(flags.cc_sat, 0)
        safe_set(flags.cc_con, 0)
        safe_set(flags.tint_trans, 50)

        config_state.tint_color = {r = 1, g = 0, b = 0}
        config_state.map_color = {r = 1, g = 1, b = 1}
        
        pcall(function()
            camera.FieldOfView = 70
        end)
        
        if tint_gui then
            tint_gui.Enabled = false
        end
        
        if tint_frame then
            tint_frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end

        loop_tickets.reset = loop_tickets.reset + 1
        local tick = loop_tickets.reset
        
        task.spawn(function()
            local start = os.clock()
            for obj, props in pairs(original_props) do
                if loop_tickets.reset ~= tick then return end
                if obj and obj.Parent then
                    pcall(function()
                        obj.Color = props.Color
                        obj.Material = props.Material
                    end)
                end
                if os.clock() - start > 0.015 then
                    task.wait()
                    start = os.clock()
                end
            end
            if loop_tickets.reset == tick then
                original_props = {}
                safe_set(flags.map_material, {l.orig})
            end
        end)
    end)
end

local function get_saved_language()
    local success, content = pcall(function()
        if isfile and isfile("ult_visuals/lang.txt") then
            return readfile("ult_visuals/lang.txt")
        end
        return nil
    end)
    
    if success and content then
        if content == "ru" or content == "en" or content == "no" then
            return content
        end
    end
    return nil
end

local function save_language(lang_code)
    pcall(function()
        if not isfolder("ult_visuals") then
            makefolder("ult_visuals")
        end
        if writefile then
            writefile("ult_visuals/lang.txt", lang_code)
        end
    end)
end

local function delete_language()
    pcall(function()
        if isfile and isfile("ult_visuals/lang.txt") then
            if delfile then
                delfile("ult_visuals/lang.txt")
            else
                writefile("ult_visuals/lang.txt", "")
            end
        end
    end)
end

local ShowLanguageSelector

local function InitMenu(lang_code)
    rayfield_lib = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local l = dict[lang_code]
    flags = {}
    
    local window = rayfield_lib:CreateWindow({
        Name = "Ultimate Visuals",
        LoadingTitle = "Загрузка",
        LoadingSubtitle = "...",
        ConfigurationSaving = {Enabled = false},
        Keybind = Enum.KeyCode.RightControl
    })

    local world_tab = window:CreateTab(l.w_name)

    flags.map_color = world_tab:CreateColorPicker({
        Name = l.map_col,
        Color = Color3.new(config_state.map_color.r, config_state.map_color.g, config_state.map_color.b),
        Flag = "map_color",
        Callback = function(color)
            pcall(function()
                config_state.map_color = {r = color.R, g = color.G, b = color.B}
                loop_tickets.color = loop_tickets.color + 1
                local tick = loop_tickets.color
                
                task.spawn(function()
                    local start = os.clock()
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if loop_tickets.color ~= tick then return end
                        if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                            local model = obj:FindFirstAncestorOfClass("Model")
                            if not (model and model:FindFirstChild("Humanoid")) then
                                save_original(obj)
                                pcall(function()
                                    obj.Color = color
                                end)
                            end
                        end
                        if os.clock() - start > 0.015 then
                            task.wait()
                            start = os.clock()
                        end
                    end
                end)
            end)
        end
    })

    local current_mat_opt = config_state.map_material[1]
    if is_original_mat(current_mat_opt) then
        current_mat_opt = l.orig
    end

    flags.map_material = world_tab:CreateDropdown({
        Name = l.map_mat,
        Options = {l.orig, "SmoothPlastic", "Neon", "ForceField", "Glass", "Ice", "Wood", "Foil"},
        CurrentOption = {current_mat_opt},
        MultipleOptions = false,
        Flag = "map_material",
        Callback = function(opt)
            pcall(function()
                config_state.map_material = opt
                local selected = type(opt) == "table" and opt[1] or opt
                
                loop_tickets.mat = loop_tickets.mat + 1
                local tick = loop_tickets.mat
                
                task.spawn(function()
                    local start = os.clock()
                    if is_original_mat(selected) then
                        for obj, props in pairs(original_props) do
                            if loop_tickets.mat ~= tick then return end
                            if obj and obj.Parent then
                                pcall(function()
                                    obj.Material = props.Material
                                end)
                            end
                            if os.clock() - start > 0.015 then
                                task.wait()
                                start = os.clock()
                            end
                        end
                    else
                        local s, m = pcall(function()
                            return Enum.Material[selected]
                        end)
                        if s and m then
                            for _, obj in ipairs(workspace:GetDescendants()) do
                                if loop_tickets.mat ~= tick then return end
                                if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                                    local model = obj:FindFirstAncestorOfClass("Model")
                                    if not (model and model:FindFirstChild("Humanoid")) then
                                        save_original(obj)
                                        pcall(function()
                                            obj.Material = m
                                        end)
                                    end
                                end
                                if os.clock() - start > 0.015 then
                                    task.wait()
                                    start = os.clock()
                                end
                            end
                        end
                    end
                end)
            end)
        end
    })

    world_tab:CreateButton({
        Name = l.res_map,
        Callback = function()
            pcall(function()
                loop_tickets.reset = loop_tickets.reset + 1
                local tick = loop_tickets.reset
                
                task.spawn(function()
                    local start = os.clock()
                    for obj, props in pairs(original_props) do
                        if loop_tickets.reset ~= tick then return end
                        if obj and obj.Parent then
                            pcall(function()
                                obj.Color = props.Color
                                obj.Material = props.Material
                            end)
                        end
                        if os.clock() - start > 0.015 then
                            task.wait()
                            start = os.clock()
                        end
                    end
                    if loop_tickets.reset == tick then
                        original_props = {}
                        safe_set(flags.map_material, {l.orig})
                        safe_set(flags.map_color, Color3.fromRGB(255, 255, 255))
                        config_state.map_color = {r = 1, g = 1, b = 1}
                    end
                end)
            end)
        end
    })

    local cam_tab = window:CreateTab(l.c_name)

    flags.fov_slider = cam_tab:CreateSlider({
        Name = l.fov,
        Range = {70, 120},
        Increment = 1,
        CurrentValue = config_state.fov_slider,
        Flag = "fov_slider",
        Callback = function(value)
            pcall(function()
                config_state.fov_slider = value
                camera.FieldOfView = value
            end)
        end
    })

    cam_tab:CreateButton({
        Name = l.res_fov,
        Callback = function()
            safe_set(flags.fov_slider, 70)
        end
    })

    local skyboxes = {
        ["vaporwave"] = "1417494030",
        ["galaxy"] = "159454286",
        ["blood moon"] = "637255909",
        ["anime night"] = "10459640960",
        ["realism"] = "6008860010",
        ["minecraft"] = "982998782",
        ["pitch black"] = "158604753"
    }

    cam_tab:CreateDropdown({
        Name = l.sky_list,
        Options = {"vaporwave", "galaxy", "blood moon", "anime night", "realism", "minecraft", "pitch black"},
        CurrentOption = {"realism"},
        MultipleOptions = false,
        Callback = function(opt)
            pcall(function()
                local selected = type(opt) == "table" and opt[1] or opt
                local id_num = skyboxes[selected]
                if id_num then
                    config_state.custom_sky = id_num
                    apply_skybox(id_num)
                end
            end)
        end
    })

    cam_tab:CreateInput({
        Name = l.sky_id,
        PlaceholderText = l.enter_id,
        RemoveTextAfterFocusLost = true,
        Callback = function(text)
            pcall(function()
                local id_numbers = text:match("%d+")
                if id_numbers then
                    config_state.custom_sky = id_numbers
                    apply_skybox(id_numbers)
                end
            end)
        end
    })

    cam_tab:CreateButton({
        Name = l.res_sky,
        Callback = reset_sky
    })

    flags.time_cycle = cam_tab:CreateToggle({
        Name = l.t_cycle,
        CurrentValue = config_state.time_cycle,
        Flag = "time_cycle",
        Callback = function(state)
            pcall(function()
                config_state.time_cycle = state
                if state then
                    if time_cycle_conn then
                        time_cycle_conn:Disconnect()
                    end
                    time_cycle_conn = run_service.Heartbeat:Connect(function(dt)
                        lighting.ClockTime = lighting.ClockTime + (dt * 0.5)
                    end)
                else
                    if time_cycle_conn then
                        time_cycle_conn:Disconnect()
                    end
                end
            end)
        end
    })

    flags.clock_time = cam_tab:CreateSlider({
        Name = l.time,
        Range = {0, 24},
        Increment = 0.5,
        CurrentValue = config_state.clock_time,
        Flag = "clock_time",
        Callback = function(value)
            pcall(function()
                config_state.clock_time = value
                lighting.ClockTime = value
            end)
        end
    })

    cam_tab:CreateButton({
        Name = l.res_time,
        Callback = function()
            safe_set(flags.clock_time, def_clock)
        end
    })

    local fx_tab = window:CreateTab(l.f_name)

    flags.shadows = fx_tab:CreateToggle({
        Name = l.shadows,
        CurrentValue = config_state.shadows,
        Flag = "shadows",
        Callback = function(state)
            pcall(function()
                config_state.shadows = state
                lighting.GlobalShadows = state
            end)
        end
    })

    flags.brightness = fx_tab:CreateSlider({
        Name = l.bright,
        Range = {0, 10},
        Increment = 0.1,
        CurrentValue = config_state.brightness,
        Flag = "brightness",
        Callback = function(value)
            pcall(function()
                config_state.brightness = value
                lighting.Brightness = value
            end)
        end
    })

    fx_tab:CreateButton({
        Name = l.res_light,
        Callback = function()
            safe_set(flags.brightness, def_brightness)
            safe_set(flags.shadows, original_lighting.GlobalShadows)
        end
    })

    flags.fog_color = fx_tab:CreateColorPicker({
        Name = l.f_col,
        Color = Color3.new(config_state.fog_color.r, config_state.fog_color.g, config_state.fog_color.b),
        Flag = "fog_color",
        Callback = function(color)
            pcall(function()
                disable_atmosphere()
                config_state.fog_color = {r = color.R, g = color.G, b = color.B}
                lighting.FogColor = color
            end)
        end
    })

    flags.fog_end = fx_tab:CreateSlider({
        Name = l.f_end,
        Range = {0, 3000},
        Increment = 50,
        CurrentValue = config_state.fog_end,
        Flag = "fog_end",
        Callback = function(value)
            pcall(function()
                disable_atmosphere()
                config_state.fog_end = value
                lighting.FogEnd = value
            end)
        end
    })

    flags.fog_start = fx_tab:CreateSlider({
        Name = l.f_start,
        Range = {0, 1000},
        Increment = 10,
        CurrentValue = config_state.fog_start,
        Flag = "fog_start",
        Callback = function(value)
            pcall(function()
                disable_atmosphere()
                config_state.fog_start = value
                lighting.FogStart = value
            end)
        end
    })

    fx_tab:CreateButton({
        Name = l.res_fog,
        Callback = function()
            safe_set(flags.fog_color, original_lighting.FogColor)
            safe_set(flags.fog_end, def_fog_end)
            safe_set(flags.fog_start, def_fog_start)
        end
    })

    flags.tint_tgl = fx_tab:CreateToggle({
        Name = l.tint,
        CurrentValue = config_state.tint_tgl,
        Flag = "tint_tgl",
        Callback = function(state)
            pcall(function()
                config_state.tint_tgl = state
                if tint_gui then
                    tint_gui.Enabled = state
                end
            end)
        end
    })

    flags.tint_color = fx_tab:CreateColorPicker({
        Name = l.t_col,
        Color = Color3.new(config_state.tint_color.r, config_state.tint_color.g, config_state.tint_color.b),
        Flag = "tint_color",
        Callback = function(color)
            pcall(function()
                config_state.tint_color = {r = color.R, g = color.G, b = color.B}
                if tint_frame then
                    tint_frame.BackgroundColor3 = color
                end
            end)
        end
    })

    flags.tint_trans = fx_tab:CreateSlider({
        Name = l.t_trans,
        Range = {0, 100},
        Increment = 1,
        CurrentValue = config_state.tint_trans,
        Flag = "tint_trans",
        Callback = function(value)
            pcall(function()
                config_state.tint_trans = value
                if tint_frame then
                    tint_frame.BackgroundTransparency = value / 100
                end
            end)
        end
    })

    fx_tab:CreateButton({
        Name = l.res_tint,
        Callback = function()
            safe_set(flags.tint_tgl, false)
            safe_set(flags.tint_trans, 50)
            safe_set(flags.tint_color, Color3.fromRGB(255, 0, 0))
            config_state.tint_color = {r = 1, g = 0, b = 0}
            if tint_frame then
                tint_frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    })

    flags.blur_tgl = fx_tab:CreateToggle({
        Name = l.blur_tgl,
        CurrentValue = config_state.blur_tgl,
        Flag = "blur_tgl",
        Callback = function(state)
            pcall(function()
                config_state.blur_tgl = state
                get_effect("BlurEffect").Enabled = state
            end)
        end
    })

    flags.blur_size = fx_tab:CreateSlider({
        Name = l.blur_sz,
        Range = {0, 56},
        Increment = 1,
        CurrentValue = config_state.blur_size,
        Flag = "blur_size",
        Callback = function(value)
            pcall(function()
                config_state.blur_size = value
                get_effect("BlurEffect").Size = value
            end)
        end
    })

    flags.sun_tgl = fx_tab:CreateToggle({
        Name = l.sun_tgl,
        CurrentValue = config_state.sun_tgl,
        Flag = "sun_tgl",
        Callback = function(state)
            pcall(function()
                config_state.sun_tgl = state
                get_effect("SunRaysEffect").Enabled = state
            end)
        end
    })

    flags.sun_int = fx_tab:CreateSlider({
        Name = l.sun_int,
        Range = {0, 1},
        Increment = 0.05,
        CurrentValue = config_state.sun_int,
        Flag = "sun_int",
        Callback = function(value)
            pcall(function()
                config_state.sun_int = value
                get_effect("SunRaysEffect").Intensity = value
            end)
        end
    })

    flags.sun_spread = fx_tab:CreateSlider({
        Name = l.sun_spr,
        Range = {0, 1},
        Increment = 0.05,
        CurrentValue = config_state.sun_spread,
        Flag = "sun_spread",
        Callback = function(value)
            pcall(function()
                config_state.sun_spread = value
                get_effect("SunRaysEffect").Spread = value
            end)
        end
    })

    flags.dof_tgl = fx_tab:CreateToggle({
        Name = l.dof_tgl,
        CurrentValue = config_state.dof_tgl,
        Flag = "dof_tgl",
        Callback = function(state)
            pcall(function()
                config_state.dof_tgl = state
                get_effect("DepthOfFieldEffect").Enabled = state
            end)
        end
    })

    flags.dof_radius = fx_tab:CreateSlider({
        Name = l.dof_rad,
        Range = {0, 100},
        Increment = 1,
        CurrentValue = config_state.dof_radius,
        Flag = "dof_radius",
        Callback = function(value)
            pcall(function()
                config_state.dof_radius = value
                get_effect("DepthOfFieldEffect").FocusDistance = value
            end)
        end
    })

    flags.bloom_tgl = fx_tab:CreateToggle({
        Name = l.bloom_tgl,
        CurrentValue = config_state.bloom_tgl,
        Flag = "bloom_tgl",
        Callback = function(state)
            pcall(function()
                config_state.bloom_tgl = state
                get_effect("BloomEffect").Enabled = state
            end)
        end
    })

    flags.bloom_int = fx_tab:CreateSlider({
        Name = l.bloom_int,
        Range = {0, 5},
        Increment = 0.1,
        CurrentValue = config_state.bloom_int,
        Flag = "bloom_int",
        Callback = function(value)
            pcall(function()
                config_state.bloom_int = value
                get_effect("BloomEffect").Intensity = value
            end)
        end
    })

    flags.cc_tgl = fx_tab:CreateToggle({
        Name = l.cc_tgl,
        CurrentValue = config_state.cc_tgl,
        Flag = "cc_tgl",
        Callback = function(state)
            pcall(function()
                config_state.cc_tgl = state
                get_effect("ColorCorrectionEffect").Enabled = state
            end)
        end
    })

    flags.cc_sat = fx_tab:CreateSlider({
        Name = l.cc_sat,
        Range = {-1, 2},
        Increment = 0.1,
        CurrentValue = config_state.cc_sat,
        Flag = "cc_sat",
        Callback = function(value)
            pcall(function()
                config_state.cc_sat = value
                get_effect("ColorCorrectionEffect").Saturation = value
            end)
        end
    })

    flags.cc_con = fx_tab:CreateSlider({
        Name = l.cc_con,
        Range = {0, 2},
        Increment = 0.1,
        CurrentValue = config_state.cc_con,
        Flag = "cc_con",
        Callback = function(value)
            pcall(function()
                config_state.cc_con = value
                get_effect("ColorCorrectionEffect").Contrast = value
            end)
        end
    })

    local presets_tab = window:CreateTab(l.p_name)
    
    presets_tab:CreateButton({
        Name = l.res_preset,
        Callback = clear_presets
    })

    presets_tab:CreateButton({
        Name = "Dark-Gray",
        Callback = function()
            pcall(function()
                clear_presets()
                
                safe_set(flags.clock_time, 0)
                lighting.ClockTime = 0
                
                safe_set(flags.fov_slider, 90)
                camera.FieldOfView = 90
                
                safe_set(flags.brightness, 10)
                lighting.Brightness = 10
                
                safe_set(flags.shadows, true)
                lighting.GlobalShadows = true
                
                safe_set(flags.fog_end, 3000)
                lighting.FogEnd = 3000
                
                safe_set(flags.fog_start, 0)
                lighting.FogStart = 0
                
                local fog_c = Color3.new(0.75, 0.75, 0.75)
                safe_set(flags.fog_color, fog_c)
                lighting.FogColor = fog_c
                
                safe_set(flags.tint_tgl, true)
                if tint_gui then tint_gui.Enabled = true end
                
                safe_set(flags.tint_trans, 85)
                if tint_frame then tint_frame.BackgroundTransparency = 0.85 end
                
                local tint_c = Color3.new(0.243, 0.243, 0.244)
                safe_set(flags.tint_color, tint_c)
                if tint_frame then tint_frame.BackgroundColor3 = tint_c end
                
                local map_c = Color3.new(0.27, 0.27, 0.27)
                safe_set(flags.map_color, map_c)
                
                loop_tickets.color = loop_tickets.color + 1
                local tick = loop_tickets.color
                task.spawn(function()
                    local start = os.clock()
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if loop_tickets.color ~= tick then return end
                        if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                            local model = obj:FindFirstAncestorOfClass("Model")
                            if not (model and model:FindFirstChild("Humanoid")) then
                                save_original(obj)
                                pcall(function() obj.Color = map_c end)
                            end
                        end
                        if os.clock() - start > 0.015 then task.wait(); start = os.clock() end
                    end
                end)
                
                safe_set(flags.time_cycle, false)
                if time_cycle_conn then time_cycle_conn:Disconnect() end
            end)
        end
    })

    local config_tab = window:CreateTab(l.cfg_name)
    local current_config_name = ""
    local can_save = isfolder and makefolder and writefile and readfile and listfiles

    config_tab:CreateButton({
        Name = l.copy_path,
        Callback = function()
            pcall(function()
                if setclipboard then
                    setclipboard("workspace\\ult_visuals\\configs")
                    notify("Путь скопирован")
                else
                    notify("Твой софт не поддерживает буфер обмена")
                end
            end)
        end
    })

    config_tab:CreateInput({
        Name = l.name_input,
        PlaceholderText = l.enter_name,
        RemoveTextAfterFocusLost = false,
        Callback = function(text)
            pcall(function()
                current_config_name = text
            end)
        end
    })

    local function get_config_list()
        local list = {}
        pcall(function()
            if can_save and isfolder("ult_visuals/configs") then
                for _, file in ipairs(listfiles("ult_visuals/configs")) do
                    local name = file:match("([^/\\]+)%.json$")
                    if name then
                        table.insert(list, name)
                    end
                end
            end
        end)
        return #list > 0 and list or {"Нет Конфигов"}
    end

    local config_dropdown = config_tab:CreateDropdown({
        Name = l.cfg_list,
        Options = get_config_list(),
        CurrentOption = {""},
        MultipleOptions = false,
        Callback = function(opt)
            pcall(function()
                local selected = type(opt) == "table" and opt[1] or opt
                if selected ~= "Нет Конфигов" and selected ~= "" then
                    current_config_name = selected
                end
            end)
        end
    })

    config_tab:CreateButton({
        Name = l.save,
        Callback = function()
            pcall(function()
                if not can_save then return end
                local safe_name = current_config_name:gsub("%.json$", ""):gsub('[\\/:*?"<>|]', "")
                
                if safe_name == "" or safe_name == "Нет Конфигов" then return end
                
                if not isfolder("ult_visuals") then
                    makefolder("ult_visuals")
                end
                if not isfolder("ult_visuals/configs") then
                    makefolder("ult_visuals/configs")
                end
                
                writefile("ult_visuals/configs/" .. safe_name .. ".json", http:JSONEncode(config_state))
                notify("Сохранен: " .. safe_name)
                config_dropdown:Refresh(get_config_list(), true)
            end)
        end
    })

    config_tab:CreateButton({
        Name = l.load,
        Callback = function()
            pcall(function()
                if not can_save or current_config_name == "" or current_config_name == "Нет Конфигов" then return end
                
                local safe_name = current_config_name:gsub("%.json$", "")
                local path = "ult_visuals/configs/" .. safe_name .. ".json"
                
                if isfile and isfile(path) then
                    local success, data = pcall(function()
                        return http:JSONDecode(readfile(path))
                    end)
                    
                    if success and type(data) == "table" then
                        task.spawn(function()
                            local simple_flags = {
                                "fov_slider", "time_cycle", "clock_time", "shadows", "brightness", "fog_end", "fog_start",
                                "tint_tgl", "tint_trans", "blur_tgl", "blur_size", "sun_tgl", "sun_int", "sun_spread",
                                "dof_tgl", "dof_radius", "bloom_tgl", "bloom_int", "cc_tgl", "cc_sat", "cc_con"
                            }
                            
                            for _, name in ipairs(simple_flags) do
                                if data[name] ~= nil and flags[name] then
                                    safe_set(flags[name], data[name])
                                end
                            end

                            if data.fov_slider ~= nil then camera.FieldOfView = data.fov_slider end
                            if data.shadows ~= nil then lighting.GlobalShadows = data.shadows end
                            if data.brightness ~= nil then lighting.Brightness = data.brightness end
                            if data.fog_end ~= nil then lighting.FogEnd = data.fog_end end
                            if data.fog_start ~= nil then lighting.FogStart = data.fog_start end
                            if data.clock_time ~= nil then lighting.ClockTime = data.clock_time end
                            
                            if data.custom_sky and data.custom_sky ~= "" then
                                apply_skybox(data.custom_sky)
                            end

                            if data.time_cycle ~= nil then
                                if data.time_cycle then
                                    if time_cycle_conn then
                                        time_cycle_conn:Disconnect()
                                    end
                                    time_cycle_conn = run_service.Heartbeat:Connect(function(dt)
                                        lighting.ClockTime = lighting.ClockTime + (dt * 0.5)
                                    end)
                                else
                                    if time_cycle_conn then
                                        time_cycle_conn:Disconnect()
                                    end
                                end
                            end
                            
                            if data.blur_tgl ~= nil then get_effect("BlurEffect").Enabled = data.blur_tgl end
                            if data.blur_size ~= nil then get_effect("BlurEffect").Size = data.blur_size end
                            if data.sun_tgl ~= nil then get_effect("SunRaysEffect").Enabled = data.sun_tgl end
                            if data.sun_int ~= nil then get_effect("SunRaysEffect").Intensity = data.sun_int end
                            if data.sun_spread ~= nil then get_effect("SunRaysEffect").Spread = data.sun_spread end
                            if data.dof_tgl ~= nil then get_effect("DepthOfFieldEffect").Enabled = data.dof_tgl end
                            if data.dof_radius ~= nil then get_effect("DepthOfFieldEffect").FocusDistance = data.dof_radius end
                            if data.bloom_tgl ~= nil then get_effect("BloomEffect").Enabled = data.bloom_tgl end
                            if data.bloom_int ~= nil then get_effect("BloomEffect").Intensity = data.bloom_int end
                            if data.cc_tgl ~= nil then get_effect("ColorCorrectionEffect").Enabled = data.cc_tgl end
                            if data.cc_sat ~= nil then get_effect("ColorCorrectionEffect").Saturation = data.cc_sat end
                            if data.cc_con ~= nil then get_effect("ColorCorrectionEffect").Contrast = data.cc_con end
                            
                            if data.tint_tgl ~= nil and tint_gui then
                                tint_gui.Enabled = data.tint_tgl
                            end
                            
                            if data.tint_trans ~= nil and tint_frame then
                                tint_frame.BackgroundTransparency = data.tint_trans / 100
                            end

                            local color_flags = {"fog_color", "tint_color", "map_color"}
                            for _, name in ipairs(color_flags) do
                                if data[name] ~= nil and flags[name] and type(data[name]) == "table" then
                                    local col = Color3.new(data[name].r, data[name].g, data[name].b)
                                    safe_set(flags[name], col)
                                    
                                    if name == "fog_color" then
                                        pcall(function()
                                            lighting.FogColor = col
                                        end)
                                    elseif name == "tint_color" then
                                        if tint_frame then
                                            tint_frame.BackgroundColor3 = col
                                        end
                                    elseif name == "map_color" then
                                        loop_tickets.color = loop_tickets.color + 1
                                        local tick = loop_tickets.color
                                        task.spawn(function()
                                            local start = os.clock()
                                            for _, obj in ipairs(workspace:GetDescendants()) do
                                                if loop_tickets.color ~= tick then return end
                                                if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                                                    local model = obj:FindFirstAncestorOfClass("Model")
                                                    if not (model and model:FindFirstChild("Humanoid")) then
                                                        save_original(obj)
                                                        pcall(function()
                                                            obj.Color = col
                                                        end)
                                                    end
                                                end
                                                if os.clock() - start > 0.015 then
                                                    task.wait()
                                                    start = os.clock()
                                                end
                                            end
                                        end)
                                    end
                                end
                            end

                            if data.map_material and flags.map_material then
                                local mat_val = type(data.map_material) == "table" and data.map_material or {data.map_material}
                                safe_set(flags.map_material, mat_val)
                                local selected = mat_val[1]
                                loop_tickets.mat = loop_tickets.mat + 1
                                local tick = loop_tickets.mat
                                
                                task.spawn(function()
                                    local start = os.clock()
                                    if is_original_mat(selected) then
                                        for obj, props in pairs(original_props) do
                                            if loop_tickets.mat ~= tick then return end
                                            if obj and obj.Parent then
                                                pcall(function()
                                                    obj.Material = props.Material
                                                end)
                                            end
                                            if os.clock() - start > 0.015 then
                                                task.wait()
                                                start = os.clock()
                                            end
                                        end
                                    else
                                        local s, m = pcall(function()
                                            return Enum.Material[selected]
                                        end)
                                        if s and m then
                                            for _, obj in ipairs(workspace:GetDescendants()) do
                                                if loop_tickets.mat ~= tick then return end
                                                if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                                                    local model = obj:FindFirstAncestorOfClass("Model")
                                                    if not (model and model:FindFirstChild("Humanoid")) then
                                                        save_original(obj)
                                                        pcall(function()
                                                            obj.Material = m
                                                        end)
                                                    end
                                                end
                                                if os.clock() - start > 0.015 then
                                                    task.wait()
                                                    start = os.clock()
                                                end
                                            end
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end
            end)
        end
    })

    config_tab:CreateButton({
        Name = l.upd,
        Callback = function()
            pcall(function()
                config_dropdown:Refresh(get_config_list(), true)
            end)
        end
    })

    local settings_tab = window:CreateTab(l.s_name)

    settings_tab:CreateButton({
        Name = l.scr_mode,
        Callback = function()
            pcall(function()
                local menu = core_gui:FindFirstChild("Rayfield")
                if menu then
                    menu.Enabled = false
                    task.wait(3)
                    menu.Enabled = true
                end
            end)
        end
    })
    
    settings_tab:CreateButton({
        Name = l.change_lang,
        Callback = function()
            pcall(function()
                delete_language()
                if rayfield_lib then rayfield_lib:Destroy() end
                ShowLanguageSelector()
            end)
        end
    })

    settings_tab:CreateButton({
        Name = l.h_reset,
        Callback = function()
            reset_all(l)
        end
    })

    settings_tab:CreateButton({
        Name = l.unload,
        Callback = function()
            pcall(function()
                reset_all(l)
                if time_cycle_conn then
                    time_cycle_conn:Disconnect()
                end
                if tint_gui then
                    tint_gui:Destroy()
                end
                if rayfield_lib then rayfield_lib:Destroy() end
            end)
        end
    })
end

ShowLanguageSelector = function()
    local start_gui = Instance.new("ScreenGui")
    start_gui.Name = "lang_select_gui"
    start_gui.Parent = core_gui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 300, 0, 260)
    bg.Position = UDim2.new(0.5, -150, 0.5, -130)
    bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    bg.BorderSizePixel = 0
    bg.Parent = start_gui
    
    local topbar = Instance.new("Frame")
    topbar.Size = UDim2.new(1, 0, 0, 30)
    topbar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    topbar.BorderSizePixel = 0
    topbar.Parent = bg
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "Language / Язык / Språk"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextSize = 16
    title.Font = Enum.Font.GothamSemibold
    title.Parent = topbar
    
    local close_btn = Instance.new("TextButton")
    close_btn.Size = UDim2.new(0, 30, 0, 30)
    close_btn.Position = UDim2.new(1, -30, 0, 0)
    close_btn.Text = "X"
    close_btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    close_btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    close_btn.BorderSizePixel = 0
    close_btn.TextSize = 18
    close_btn.Font = Enum.Font.GothamBold
    close_btn.Parent = topbar
    
    close_btn.MouseButton1Click:Connect(function()
        start_gui:Destroy()
    end)
    
    local dragging, dragInput, dragStart, startPos
    
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = bg.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            bg.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local function create_btn(txt, pos_y, code)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 260, 0, 40)
        btn.Position = UDim2.new(0.5, -130, 0, pos_y)
        btn.Text = txt
        btn.TextSize = 16
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.Parent = bg
        
        btn.MouseButton1Click:Connect(function()
            save_language(code)
            start_gui:Destroy()
            InitMenu(code)
        end)
    end

    create_btn("Русский", 50, "ru")
    create_btn("English", 110, "en")
    create_btn("Norsk", 170, "no")
end

local saved_language = get_saved_language()

if saved_language then
    InitMenu(saved_language)
else
    ShowLanguageSelector()
end