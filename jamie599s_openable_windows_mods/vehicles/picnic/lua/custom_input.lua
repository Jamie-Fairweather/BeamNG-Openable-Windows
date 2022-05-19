local M = {}

FLWindowPressTimer = 0
FLWindowPressLast = 0

FRWindowPressTimer = 0
FRWindowPressLast = 0

local function reset()
  electrics.values['FLWindow'] = 0
  electrics.values['FLWindowPress'] = 0
  FLWindowPressTimer = 0
  FLWindowPressLast = 0

  electrics.values['FRWindow'] = 0
  electrics.values['FRWindowPress'] = 0
  FRWindowPressTimer = 0
  FRWindowPressLast = 0
end

local function updateGFX(dt) -- ms 
  -- L Window Press/Hold Detecton
  if electrics.values.FLWindowPress ~= 0 and FLWindowPressLast == 0 then
    FLWindowPressTimer = 0.2
  end
  
  if FLWindowPressTimer > 0 then
    FLWindowPressTimer = FLWindowPressTimer - dt

    if electrics.values.FLWindowPress == 0 and FLWindowPressLast ~= 0 then
      electrics.values.FLWindow = FLWindowPressLast
    end

    if FLWindowPressTimer < 0 then
      FLWindowPressTimer = 0
    end
  end

  FLWindowPressLast = electrics.values.FLWindowPress    


  -- R Window Press/Hold Detecton
  if electrics.values.FRWindowPress ~= 0 and FRWindowPressLast == 0 then
    FRWindowPressTimer = 0.2
  end

  if FRWindowPressTimer > 0 then
    FRWindowPressTimer = FRWindowPressTimer - dt

    if electrics.values.FRWindowPress == 0 and FRWindowPressLast ~= 0 then
      electrics.values.FRWindow = FRWindowPressLast
    end

    if FRWindowPressTimer < 0 then
      FRWindowPressTimer = 0
    end 
  end

  FRWindowPressLast = electrics.values.FRWindowPress
  

  electrics.values.FLWindow = math.min(0, math.max(-1, electrics.values.FLWindow + electrics.values.FLWindowPress * 0.3 * dt))
  electrics.values.FRWindow = math.min(0, math.max(-1, electrics.values.FRWindow + electrics.values.FRWindowPress * 0.3 * dt))
end

M.onInit    = reset
M.onReset   = reset
M.updateGFX = updateGFX

return M
