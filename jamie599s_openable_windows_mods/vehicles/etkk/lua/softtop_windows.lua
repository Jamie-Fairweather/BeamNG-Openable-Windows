local M = {}

local function reset()
  softTopLast = 0
  softTopTimer = 0

  windowRestActive = false

  windowRestPos = -0.2
  LWindowOriginalPos = 0
  RWindowOriginalPos = 0

  electrics.values['softtop'] = 0
  electrics.values['LWindow'] = 0
  electrics.values['RWindow'] = 0
end

local function updateGFX(dt)

  if electrics.values['softtop'] ~= softTopLast then
    softTopTimer = 4.33
    windowRestActive = true

    if electrics.values['LWindow'] ~= windowRestPos then
      LWindowOriginalPos = electrics.values['LWindow']
    end
    if electrics.values['RWindow'] ~= windowRestPos then
      RWindowOriginalPos = electrics.values['RWindow']
    end

  end

  if softTopTimer > 0 then
    softTopTimer = softTopTimer - dt

    if electrics.values['LWindow'] >= windowRestPos then
      electrics.values['LWindow'] = windowRestPos
    else
      LWindowOriginalPos = electrics.values['LWindow']
    end

    if electrics.values['RWindow'] >= windowRestPos then
      electrics.values['RWindow'] = windowRestPos
    else
      RWindowOriginalPos = electrics.values['RWindow']
    end

    if softTopTimer < 0 then
      softTopTimer = 0
    end
  end

  if windowRestActive == true and softTopTimer == 0 then
    electrics.values['LWindow'] = LWindowOriginalPos
    electrics.values['RWindow'] = RWindowOriginalPos
    windowRestActive = false
  end

  softTopLast = electrics.values['softtop']
end

M.onInit    = reset
M.onReset   = reset
M.updateGFX = updateGFX

return M
