-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Clean previous GUI if exists
local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("FROY_MobileUI_V2")
if oldGui then oldGui:Destroy() end

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FROY_MobileUI_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

---------------------------------------------------------
-- 0. LOGO BUTTON (ปุ่มเปิด-ปิดเมนู)
---------------------------------------------------------
local LogoButton = Instance.new("TextButton")
LogoButton.Name = "FROY_Logo"
LogoButton.Size = UDim2.new(0, 45, 0, 45)
LogoButton.Position = UDim2.new(0.03, 0, 0.12, 0)
LogoButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogoButton.Text = "FROY"
LogoButton.TextColor3 = Color3.fromRGB(255, 0, 0)
LogoButton.Font = Enum.Font.FredokaOne
LogoButton.TextSize = 13
LogoButton.Active = true
LogoButton.Draggable = true
LogoButton.Parent = ScreenGui

Instance.new("UICorner", LogoButton).CornerRadius = UDim.new(1, 0)
local LogoStroke = Instance.new("UIStroke", LogoButton)
LogoStroke.Thickness = 2
LogoStroke.Color = Color3.fromRGB(255, 0, 0)

-- สลับสีโลโก้ 6 สี (แดง, ดำ, ขาว, เขียว, ม่วง, ฟ้า)
local NeonColors = {
	Color3.fromRGB(255, 0, 80),
	Color3.fromRGB(50, 50, 50),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(0, 255, 127),
	Color3.fromRGB(170, 0, 255),
	Color3.fromRGB(0, 210, 255)
}
task.spawn(function()
	local idx = 1
	while true do
		idx = (idx % #NeonColors) + 1
		LogoButton.TextColor3 = NeonColors[idx]
		LogoStroke.Color = NeonColors[idx]
		task.wait(1)
	end
end)

---------------------------------------------------------
-- MAIN FRAME (หน้าต่างหลัก ขอบเรนโบว์ ด้านในดำ)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3

-- ขอบเรนโบว์วิ่งวน
local RainbowGradient = Instance.new("UIGradient", MainStroke)
RainbowGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
	ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
	ColorSequenceKeypoint.new(0.8, Color3.fromRGB(139, 0, 255)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})
task.spawn(function()
	while true do
		RainbowGradient.Rotation = (RainbowGradient.Rotation + 3) % 360
		task.wait(0.03)
	end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "FROY MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 15
Title.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -10, 1, -40)
Container.Position = UDim2.new(0, 5, 0, 35)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
Container.CanvasSize = UDim2.new(0, 0, 0, 430)
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)
UIList.Parent = Container

LogoButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

local function CreateSec(name, order, height)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1, 0, 0, height or 60)
	f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	f.LayoutOrder = order
	f.Parent = Container
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
	
	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1, -10, 0, 18)
	t.Position = UDim2.new(0, 5, 0, 2)
	t.BackgroundTransparency = 1
	t.Text = name
	t.TextColor3 = Color3.fromRGB(0, 210, 255)
	t.Font = Enum.Font.SourceSansBold
	t.TextSize = 12
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.Parent = f
	return f
end

---------------------------------------------------------
-- 1. กระโดดไม่จำกัด (1-200)
---------------------------------------------------------
local S1 = CreateSec("1. กระโดดไม่จำกัด (1-200)", 1, 60)
local JOn = false local JPow = 50
local JBtn = Instance.new("TextButton", S1)
JBtn.Size = UDim2.new(0.45, 0, 0, 32) JBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
JBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) JBtn.Text = "ปิด" JBtn.TextColor3 = Color3.fromRGB(255,255,255) JBtn.TextSize = 12
Instance.new("UICorner", JBtn)

local JIn = Instance.new("TextBox", S1)
JIn.Size = UDim2.new(0.45, 0, 0, 32) JIn.Position = UDim2.new(0.53, 0, 0.4, 0)
JIn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) JIn.Text = "50" JIn.TextColor3 = Color3.fromRGB(255,255,255) JIn.TextSize = 12
Instance.new("UICorner", JIn)

JBtn.MouseButton1Click:Connect(function()
	JOn = not JOn
	JBtn.Text = JOn and "เปิด" or "ปิด"
	JBtn.BackgroundColor3 = JOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)
JIn.FocusLost:Connect(function() JPow = math.clamp(tonumber(JIn.Text) or 50, 1, 200) JIn.Text = tostring(JPow) end)

UserInputService.JumpRequest:Connect(function()
	if JOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
		if hum.UseJumpPower then hum.JumpPower = JPow else hum.JumpHeight = JPow / 3 end
	end
end)

---------------------------------------------------------
-- 2. หมุนตัว (1-500)
---------------------------------------------------------
local S2 = CreateSec("2. หมุนตัว (1-500)", 2, 60)
local SOn = false local SSpeed = 50
local SBtn = Instance.new("TextButton", S2)
SBtn.Size = UDim2.new(0.45, 0, 0, 32) SBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
SBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) SBtn.Text = "ปิด" SBtn.TextColor3 = Color3.fromRGB(255,255,255) SBtn.TextSize = 12
Instance.new("UICorner", SBtn)

local SIn = Instance.new("TextBox", S2)
SIn.Size = UDim2.new(0.45, 0, 0, 32) SIn.Position = UDim2.new(0.53, 0, 0.4, 0)
SIn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) SIn.Text = "50" SIn.TextColor3 = Color3.fromRGB(255,255,255) SIn.TextSize = 12
Instance.new("UICorner", SIn)

SBtn.MouseButton1Click:Connect(function()
	SOn = not SOn
	SBtn.Text = SOn and "เปิด" or "ปิด"
	SBtn.BackgroundColor3 = SOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)
SIn.FocusLost:Connect(function() SSpeed = math.clamp(tonumber(SIn.Text) or 50, 1, 500) SIn.Text = tostring(SSpeed) end)

RunService.RenderStepped:Connect(function()
	if SOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SSpeed), 0)
	end
end)

---------------------------------------------------------
-- 3. วิ่งเร็ว กันบัค (1-300)
---------------------------------------------------------
local S3 = CreateSec("3. วิ่งเร็ว กันบัค (1-300)", 3, 60)
local SpdOn = false local SpdVal = 100
local SpdBtn = Instance.new("TextButton", S3)
SpdBtn.Size = UDim2.new(0.45, 0, 0, 32) SpdBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
SpdBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) SpdBtn.Text = "ปิด" SpdBtn.TextColor3 = Color3.fromRGB(255,255,255) SpdBtn.TextSize = 12
Instance.new("UICorner", SpdBtn)

local SpdIn = Instance.new("TextBox", S3)
SpdIn.Size = UDim2.new(0.45, 0, 0, 32) SpdIn.Position = UDim2.new(0.53, 0, 0.4, 0)
SpdIn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) SpdIn.Text = "100" SpdIn.TextColor3 = Color3.fromRGB(255,255,255) SpdIn.TextSize = 12
Instance.new("UICorner", SpdIn)

SpdBtn.MouseButton1Click:Connect(function()
	SpdOn = not SpdOn
	SpdBtn.Text = SpdOn and "เปิด" or "ปิด"
	SpdBtn.BackgroundColor3 = SpdOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
	if not SpdOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
	end
end)
SpdIn.FocusLost:Connect(function() SpdVal = math.clamp(tonumber(SpdIn.Text) or 100, 1, 300) SpdIn.Text = tostring(SpdVal) end)

RunService.Heartbeat:Connect(function()
	if SpdOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = SpdVal
	end
end)

---------------------------------------------------------
-- 4. ESP (มองผู้เล่นเป็นสีชมพูคมชัด + ชื่อ)
---------------------------------------------------------
local S4 = CreateSec("4. มองผู้เล่นสีชมพู + ชื่อ (ESP)", 4, 60)
local ESPOn = false
local ESPStorage = {}

local ESPBtn = Instance.new("TextButton", S4)
ESPBtn.Size = UDim2.new(0.96, 0, 0, 32) ESPBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ESPBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) ESPBtn.Text = "ปิด ESP" ESPBtn.TextColor3 = Color3.fromRGB(255,255,255) ESPBtn.TextSize = 12
Instance.new("UICorner", ESPBtn)

local function RemoveESP(plr)
	if ESPStorage[plr] then
		if ESPStorage[plr].Highlight then ESPStorage[plr].Highlight:Destroy() end
		if ESPStorage[plr].Billboard then ESPStorage[plr].Billboard:Destroy() end
		ESPStorage[plr] = nil
	end
end

local function ApplyESP(plr)
	if plr == LocalPlayer then return end
	local function OnChar(char)
		task.wait(0.5)
		if not ESPOn then return end
		-- สร้าง Highlight สีชมพู
		local hl = Instance.new("Highlight")
		hl.Name = "FROY_ESP"
		hl.FillColor = Color3.fromRGB(255, 20, 147) -- ชมพูคมชัด
		hl.OutlineColor = Color3.fromRGB(255, 255, 255)
		hl.FillTransparency = 0.3
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		hl.Parent = char
		
		-- ชื่อเหนือหัว
		local head = char:WaitForChild("Head", 5)
		if head then
			local bg = Instance.new("BillboardGui")
			bg.Size = UDim2.new(0, 150, 0, 30)
			bg.StudsOffset = Vector3.new(0, 2.5, 0)
			bg.AlwaysOnTop = true
			
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1,0,1,0)
			lbl.BackgroundTransparency = 1
			lbl.Text = plr.Name
			lbl.TextColor3 = Color3.fromRGB(255, 105, 180) -- สีชมพู
			lbl.TextSize = 13
			lbl.Font = Enum.Font.SourceSansBold
			lbl.TextStrokeTransparency = 0
			lbl.Parent = bg
			
			bg.Parent = head
			ESPStorage[plr] = {Highlight = hl, Billboard = bg}
		end
	end
	if plr.Character then OnChar(plr.Character) end
	plr.CharacterAdded:Connect(OnChar)
end

ESPBtn.MouseButton1Click:Connect(function()
	ESPOn = not ESPOn
	ESPBtn.Text = ESPOn and "เปิด ESP" or "ปิด ESP"
	ESPBtn.BackgroundColor3 = ESPOn and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
	
	if ESPOn then
		for _, p in pairs(Players:GetPlayers()) do ApplyESP(p) end
	else
		for p, _ in pairs(ESPStorage) do RemoveESP(p) end
	end
end)

Players.PlayerAdded:Connect(function(p) if ESPOn then ApplyESP(p) end end)
Players.PlayerRemoving:Connect(RemoveESP)

---------------------------------------------------------
-- 5. วาปไปหาผู้เล่น + หน้าต่างรายชื่อ (ก็อปชื่ออัตโนมัติ)
---------------------------------------------------------
local S5 = CreateSec("5. วาปไปหาผู้เล่น (Teleport)", 5, 95)

local TIn = Instance.new("TextBox", S5)
TIn.Size = UDim2.new(0.6, 0, 0, 30) TIn.Position = UDim2.new(0.02, 0, 0.32, 0)
TIn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) TIn.PlaceholderText = "ชื่อผู้เล่น..." TIn.TextColor3 = Color3.fromRGB(255,255,255) TIn.TextSize = 12
Instance.new("UICorner", TIn)

local ListBtn = Instance.new("TextButton", S5)
ListBtn.Size = UDim2.new(0.34, 0, 0, 30) ListBtn.Position = UDim2.new(0.64, 0, 0.32, 0)
ListBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 200) ListBtn.Text = "รายชื่อ" ListBtn.TextColor3 = Color3.fromRGB(255,255,255) ListBtn.TextSize = 12
Instance.new("UICorner", ListBtn)

local TPBtn = Instance.new("TextButton", S5)
TPBtn.Size = UDim2.new(0.96, 0, 0, 30) TPBtn.Position = UDim2.new(0.02, 0, 0.66, 0)
TPBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 0) TPBtn.Text = "ยืนยันการวาป" TPBtn.TextColor3 = Color3.fromRGB(255,255,255) TPBtn.TextSize = 12
Instance.new("UICorner", TPBtn)

-- หน้าต่างรายชื่อผู้เล่น (กดแล้วดึงชื่อใส่ช่องอัตโนมัติ ไม่หายแน่นอน)
local PlrFrame = Instance.new("Frame", ScreenGui)
PlrFrame.Size = UDim2.new(0, 220, 0, 240)
PlrFrame.Position = UDim2.new(0.5, -110, 0.5, -120)
PlrFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PlrFrame.Visible = false
PlrFrame.Active = true
PlrFrame.Draggable = true
Instance.new("UICorner", PlrFrame).CornerRadius = UDim.new(0, 8)
local PlrStroke = Instance.new("UIStroke", PlrFrame)
PlrStroke.Thickness = 2 PlrStroke.Color = Color3.fromRGB(255, 0, 150)

local PlrTitle = Instance.new("TextLabel", PlrFrame)
PlrTitle.Size = UDim2.new(1, -30, 0, 28) PlrTitle.Position = UDim2.new(0, 8, 0, 0)
PlrTitle.BackgroundTransparency = 1 PlrTitle.Text = "แตะชื่อเพื่อเลือก" PlrTitle.TextColor3 = Color3.fromRGB(255,255,255) PlrTitle.TextSize = 12 PlrTitle.TextXAlignment = Enum.TextXAlignment.Left

local ClosePlr = Instance.new("TextButton", PlrFrame)
ClosePlr.Size = UDim2.new(0, 25, 0, 25) ClosePlr.Position = UDim2.new(1, -28, 0, 2)
ClosePlr.BackgroundTransparency = 1 ClosePlr.Text = "X" ClosePlr.TextColor3 = Color3.fromRGB(255,50,50) ClosePlr.TextSize = 14 ClosePlr.Font = Enum.Font.FredokaOne
ClosePlr.MouseButton1Click:Connect(function() PlrFrame.Visible = false end)

local PlrScroll = Instance.new("ScrollingFrame", PlrFrame)
PlrScroll.Size = UDim2.new(1, -10, 1, -32) PlrScroll.Position = UDim2.new(0, 5, 0, 30)
PlrScroll.BackgroundTransparency = 1 PlrScroll.ScrollBarThickness = 3
local PlrLayout = Instance.new("UIListLayout", PlrScroll)
PlrLayout.SortOrder = Enum.SortOrder.LayoutOrder PlrLayout.Padding = UDim.new(0, 4)

local function RefreshList()
	for _, c in pairs(PlrScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	local cnt = 0
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			cnt = cnt + 1
			local b = Instance.new("TextButton", PlrScroll)
			b.Size = UDim2.new(1, -4, 0, 30) b.BackgroundColor3 = Color3.fromRGB(40,40,40)
			b.Text = p.Name b.TextColor3 = Color3.fromRGB(255,255,255) b.TextSize = 12
			Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
			b.MouseButton1Click:Connect(function()
				TIn.Text = p.Name
				PlrFrame.Visible = false
			end)
		end
	end
	PlrScroll.CanvasSize = UDim2.new(0,0,0, cnt * 34)
end

ListBtn.MouseButton1Click:Connect(function()
	PlrFrame.Visible = not PlrFrame.Visible
	if PlrFrame.Visible then RefreshList() end
end)

TPBtn.MouseButton1Click:Connect(function()
	local target = nil
	for _, p in pairs(Players:GetPlayers()) do
		if string.lower(p.Name) == string.lower(TIn.Text) or string.lower(p.DisplayName) == string.lower(TIn.Text) then
			target = p break
		end
	end
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
	else
		TPBtn.Text = "ไม่พบผู้เล่น!"
		task.wait(1)
		TPBtn.Text = "ยืนยันการวาป"
	end
end)
