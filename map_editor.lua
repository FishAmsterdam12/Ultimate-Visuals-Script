local core_gui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
    core_gui = (gethui and gethui()) or game:GetService("CoreGui")
end)

local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local local_player = players.LocalPlayer
local mouse = local_player:GetMouse()
local http = game:GetService("HttpService")
local run_service = game:GetService("RunService")

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()

local original_props = {}
local isolated_parts = {}
local undo_stack = {}
local redo_stack = {}
local max_history = 20

local target_part = nil
local selection_box = Instance.new("SelectionBox")
selection_box.Color3 = Color3.fromRGB(0, 255, 255)
selection_box.LineThickness = 0.05
selection_box.Parent = core_gui

local function save_backup(obj)
    if not original_props[obj] then
        original_props[obj] = {
            Color = obj.Color,
            Material = obj.Material,
            Transparency = obj.Transparency,
            Reflectance = obj.Reflectance,
            CastShadow = obj.CastShadow,
            CanCollide = obj.CanCollide,
            Anchored = obj.Anchored,
            Size = obj.Size,
            Parent = obj.Parent
        }
    end
end

local function push_history(action_type, parts_list)
    local state_entry = {type = action_type, data = {}}
    for _, part in ipairs(parts_list) do
        if part and part.Parent then
            table.insert(state_entry.data, {
                obj = part,
                Color = part.Color,
                Material = part.Material,
                Transparency = part.Transparency,
                Reflectance = part.Reflectance,
                CastShadow = part.CastShadow,
                CanCollide = part.CanCollide,
                Anchored = part.Anchored
            })
        end
    end
    table.insert(undo_stack, state_entry)
    if #undo_stack > max_history then table.remove(undo_stack, 1) end
    table.clear(redo_stack)
end

local function get_filtered_parts(main_part)
    local result = {}
    local filter = Options.FilterType.Value
    local radius = Options.RadiusSlider.Value

    if filter == "Одна деталь" then
        if not isolated_parts[main_part] then table.insert(result, main_part) end
    elseif filter == "Тот же материал" then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Material == main_part.Material and not isolated_parts[obj] then
                table.insert(result, obj)
            end
        end
    elseif filter == "Тот же цвет" then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Color == main_part.Color and not isolated_parts[obj] then
                table.insert(result, obj)
            end
        end
    elseif filter == "Тот же класс" then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.ClassName == main_part.ClassName and not isolated_parts[obj] then
                table.insert(result, obj)
            end
        end
    elseif filter == "Радиус сферы" then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not isolated_parts[obj] then
                local dist = (obj.Position - main_part.Position).Magnitude
                if dist <= radius then table.insert(result, obj) end
            end
        end
    end
    return result
end

local Window = Library:CreateWindow({
    Title = 'Map Editor Pro — Панель управления',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Inspector = Window:CreateTab('Пипетка и инспектор'),
    ColorTab = Window:CreateTab('Цвет и тон'),
    MaterialTab = Window:CreateTab('Материалы и физика'),
    HistoryTab = Window:CreateTab('История и конфиги')
}

local ToolBox = Tabs.Inspector:CreateLeftGroupbox('Инструменты выделения')

ToolBox:AddToggle('PickerActive', {
    Text = 'Активировать пипетку (Клик по карте)',
    Default = false,
    Tooltip = 'Включает режим выбора деталей кликом мыши'
})

ToolBox:AddToggle('ShowHighlight', {
    Text = 'Подсвечивать цель',
    Default = true,
    Tooltip = 'Показывает рамку вокруг выбранного объекта'
})

ToolBox:AddDropdown('FilterType', {
    Values = {'Одна деталь', 'Тот же материал', 'Тот же цвет', 'Тот же класс', 'Радиус сферы'},
    Default = 1,
    Multi = false,
    Text = 'Зона применения (Фильтр слоев)',
})

ToolBox:AddSlider('RadiusSlider', {
    Text = 'Радиус фильтра (метры)',
    Default = 50,
    Min = 5,
    Max = 500,
    Round = 1,
    Compact = false
})

local InfoBox = Tabs.Inspector:CreateRightGroupbox('Данные выбранного объекта')
local info_lbl_name = InfoBox:AddLabel('Имя: нет')
local info_lbl_mat = InfoBox:AddLabel('Материал: нет')
local info_lbl_col = InfoBox:AddLabel('Цвет: нет')
local info_lbl_trans = InfoBox:AddLabel('Прозрачность: нет')

local ColorBox = Tabs.ColorTab:CreateLeftGroupbox('Коррекция цвета')

local color_label = ColorBox:AddLabel('Основной цвет')
color_label:AddColorPicker('TargetColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Палитра'
})

ColorBox:AddDropdown('BlendMode', {
    Values = {'Замена', 'Умножение (Multiply)', 'Инверсия исходного'},
    Default = 1,
    Multi = false,
    Text = 'Режим наложения цвета',
})

ColorBox:AddSlider('ColorBrightness', {
    Text = 'Множитель яркости',
    Default = 1,
    Min = 0,
    Max = 3,
    Round = 2,
    Compact = false
})

local PhysicsBox = Tabs.MaterialTab:CreateLeftGroupbox('Физические свойства')

PhysicsBox:AddDropdown('TargetMaterial', {
    Values = {'SmoothPlastic', 'Neon', 'ForceField', 'Glass', 'Ice', 'Wood', 'Foil', 'Grass', 'Brick', 'Slate'},
    Default = 1,
    Multi = false,
    Text = 'Новый материал',
})

PhysicsBox:AddSlider('PartTransparency', {
    Text = 'Прозрачность',
    Default = 0,
    Min = 0,
    Max = 1,
    Round = 2,
    Compact = false
})

PhysicsBox:AddSlider('PartReflectance', {
    Text = 'Отражение',
    Default = 0,
    Min = 0,
    Max = 1,
    Round = 2,
    Compact = false
})

local FlagsBox = Tabs.MaterialTab:CreateRightGroupbox('Переключатели состояния')

FlagsBox:AddToggle('SetCastShadow', { Text = 'Отображение тени', Default = true })
FlagsBox:AddToggle('SetCanCollide', { Text = 'Коллизия (Проходимость)', Default = true })
FlagsBox:AddToggle('SetAnchored', { Text = 'Закрепить в воздухе', Default = true })
FlagsBox:AddToggle('IsIsolated', { 
    Text = 'Изолировать деталь от изменений', 
    Default = false,
    Tooltip = 'Запирает объект, защищая от массового перекрашивания' 
})

local ActionBox = Tabs.ColorTab:CreateRightGroupbox('Действия')

ActionBox:AddButton({
    Text = 'Применить настройки к зоне',
    Func = function()
        if not target_part or not target_part.Parent then return end
        local targets = get_filtered_parts(target_part)
        if #targets == 0 then return end
        
        push_history("Modify", targets)
        
        local new_color = Options.TargetColor.Value
        local blend = Options.BlendMode.Value
        local bright = Options.ColorBrightness.Value
        local mat_str = Options.TargetMaterial.Value
        local trans = Options.PartTransparency.Value
        local refl = Options.PartReflectance.Value
        local shadow = Toggles.SetCastShadow.Value
        local collide = Toggles.SetCanCollide.Value
        local anchor = Toggles.SetAnchored.Value
        
        task.spawn(function()
            for _, obj in ipairs(targets) do
                pcall(function()
                    save_backup(obj)
                    
                    if blend == "Замена" then
                        obj.Color = Color3.new(new_color.R * bright, new_color.G * bright, new_color.B * bright)
                    elseif blend == "Умножение (Multiply)" then
                        local orig = original_props[obj].Color
                        obj.Color = Color3.new(orig.R * new_color.R * bright, orig.G * new_color.G * bright, orig.B * new_color.B * bright)
                    elseif blend == "Инверсия исходного" then
                        local orig = original_props[obj].Color
                        obj.Color = Color3.new(1 - orig.R, 1 - orig.G, 1 - orig.B)
                    end
                    
                    obj.Material = Enum.Material[mat_str]
                    obj.Transparency = trans
                    obj.Reflectance = refl
                    obj.CastShadow = shadow
                    obj.CanCollide = collide
                    obj.Anchored = anchor
                end)
            end
        end)
    end
})

ActionBox:AddButton({
    Text = 'Удалить деталь (Ластик)',
    Func = function()
        if not target_part or not target_part.Parent then return end
        push_history("Delete", {target_part})
        save_backup(target_part)
        target_part.Parent = nil
        target_part = nil
        selection_box.Adornee = nil
    end
})

local HistoryBox = Tabs.HistoryTab:CreateLeftGroupbox('Управление историей')

HistoryBox:AddButton({
    Text = 'Отмена действия (Undo)',
    Func = function()
        if #undo_stack == 0 then return end
        local last_action = table.remove(undo_stack)
        
        local current_states = {}
        for _, item in ipairs(last_action.data) do
            if item.obj then table.insert(current_states, item.obj) end
        end
        push_history("RedoStack", current_states)
        table.insert(redo_stack, table.remove(undo_stack)) 
        
        for _, item in ipairs(last_action.data) do
            local obj = item.obj
            if obj then
                pcall(function()
                    obj.Color = item.Color
                    obj.Material = item.Material
                    obj.Transparency = item.Transparency
                    obj.Reflectance = item.Reflectance
                    obj.CastShadow = item.CastShadow
                    obj.CanCollide = item.CanCollide
                    obj.Anchored = item.Anchored
                end)
            end
        end
    end
})

HistoryBox:AddButton({
    Text = 'Полный сброс всей карты',
    Func = function()
        task.spawn(function()
            for obj, props in pairs(original_props) do
                if obj and obj.Parent then
                    pcall(function()
                        obj.Color = props.Color
                        obj.Material = props.Material
                        obj.Transparency = props.Transparency
                        obj.Reflectance = props.Reflectance
                        obj.CastShadow = props.CastShadow
                        obj.CanCollide = props.CanCollide
                        obj.Anchored = props.Anchored
                        obj.Parent = props.Parent
                    end)
                end
            end
            table.clear(original_props)
            table.clear(isolated_parts)
            table.clear(undo_stack)
            table.clear(redo_stack)
            target_part = nil
            selection_box.Adornee = nil
        end)
    end
})

Toggles.IsIsolated:OnChanged(function(state)
    if target_part then
        if state then
            isolated_parts[target_part] = true
        else
            isolated_parts[target_part] = nil
        end
    end
end)

run_service.RenderStepped:Connect(function()
    if Toggles.PickerActive.Value and Toggles.ShowHighlight.Value and mouse.Target and mouse.Target:IsA("BasePart") then
        selection_box.Adornee = mouse.Target
    elseif target_part and Toggles.ShowHighlight.Value then
        selection_box.Adornee = target_part
    else
        selection_box.Adornee = nil
    end
end)

mouse.Button1Down:Connect(function()
    if not Toggles.PickerActive.Value then return end
    local current_target = mouse.Target
    if current_target and current_target:IsA("BasePart") then
        target_part = current_target
        
        info_lbl_name:SetText('Имя: ' .. target_part.Name)
        info_lbl_mat:SetText('Материал: ' .. tostring(target_part.Material.Name))
        info_lbl_col:SetText('Цвет RGB: ' .. math.floor(target_part.Color.R*255) .. ', ' .. math.floor(target_part.Color.G*255) .. ', ' .. math.floor(target_part.Color.B*255))
        info_lbl_trans:SetText('Прозрачность: ' .. tostring(target_part.Transparency))
        
        Options.TargetColor:SetValueRGB(target_part.Color)
        pcall(function() Options.TargetMaterial:SetValue(target_part.Material.Name) end)
        Options.PartTransparency:SetValue(target_part.Transparency)
        Options.PartReflectance:SetValue(target_part.Reflectance)
        Toggles.SetCastShadow:SetValue(target_part.CastShadow)
        Toggles.SetCanCollide:SetValue(target_part.CanCollide)
        Toggles.SetAnchored:SetValue(target_part.Anchored)
        Toggles.IsIsolated:SetValue(isolated_parts[target_part] and true or false)
    end
end)

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'PickerActive' })
SaveManager:SetFolder('ult_visuals/map_editor')
SaveManager:BuildConfigSection(Tabs.HistoryTab)
SaveManager:LoadAutoloadConfig()
