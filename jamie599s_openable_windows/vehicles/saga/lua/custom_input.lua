local M = {}

LWindowPressTimer = 0
LWindowPressLast = 0

RWindowPressTimer = 0
RWindowPressLast = 0

local function reset()
  electrics.values['LWindow'] = 0
  electrics.values['LWindowPress'] = 0
  LWindowPressTimer = 0
  LWindowPressLast = 0

  electrics.values['RWindow'] = 0
  electrics.values['RWindowPress'] = 0
  RWindowPressTimer = 0
  RWindowPressLast = 0
end

local function updateGFX(dt) -- ms 
  -- L Window Press/Hold Detecton
  if electrics.values.LWindowPress ~= 0 and LWindowPressLast == 0 then
    LWindowPressTimer = 0.2
  end
  
  if LWindowPressTimer > 0 then
    LWindowPressTimer = LWindowPressTimer - dt

    if electrics.values.LWindowPress == 0 and LWindowPressLast ~= 0 then
      electrics.values.LWindow = LWindowPressLast
    end

    if LWindowPressTimer < 0 then
      LWindowPressTimer = 0
    end
  end

  LWindowPressLast = electrics.values.LWindowPress    


  -- R Window Press/Hold Detecton
  if electrics.values.RWindowPress ~= 0 and RWindowPressLast == 0 then
    RWindowPressTimer = 0.2
  end

  if RWindowPressTimer > 0 then
    RWindowPressTimer = RWindowPressTimer - dt

    if electrics.values.RWindowPress == 0 and RWindowPressLast ~= 0 then
      electrics.values.RWindow = RWindowPressLast
    end

    if RWindowPressTimer < 0 then
      RWindowPressTimer = 0
    end 
  end

  RWindowPressLast = electrics.values.RWindowPress
  

  electrics.values.LWindow = math.min(0, math.max(-1, electrics.values.LWindow + electrics.values.LWindowPress * 0.45 * dt))
  electrics.values.RWindow = math.min(0, math.max(-1, electrics.values.RWindow + electrics.values.RWindowPress * 0.45 * dt))
end

M.onInit    = reset
M.onReset   = reset
M.updateGFX = updateGFX

return M
