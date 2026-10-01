-- Protocol Corporation Ltda
-- t.me/FabioCarpi
-- Version 2026.10.01.00

-- Ma functions
local Cmd = gma.cmd
local Echo = gma.feedback
local Confirm = gma.gui.confirm
local ProgressRange = gma.gui.progress.setrange
local ProgressText = gma.gui.progress.settext
local ProgressStart = gma.gui.progress.start
local ProgressStop = gma.gui.progress.stop
local ProgressSet = gma.gui.progress.set
local Msgbox = gma.gui.msgbox
local Sleep = gma.sleep
local Property = gma.show.property.get
local PropName = gma.show.property.name
local Count = gma.show.getobj.amount
local Child = gma.show.getobj.child
local Class = gma.show.getobj.class
local Handle = gma.show.getobj.handle
local Label = gma.show.getobj.label
local ObjName = gma.show.getobj.name
local VarGet = gma.show.getvar
local Input = gma.textinput

function TakeSelection()
  local merge
  local grupo = 999
  local primeiro = tonumber(Input('Efeito inicial'))
  local ultimo = tonumber(Input('Efeito final'))
  if Confirm('TakeSelection', 'Merge?') then
    merge = true
    Cmd('Store Group ' .. grupo)
  else
    merge = false
  end
  local progress = ProgressStart('TakeSelection')
  ProgressRange(progress, primeiro, ultimo)
  for i = primeiro, ultimo, 1 do
    if merge then
      Cmd('ClearAll')
      Cmd('SelFix Effect ' .. i)
      Cmd('Group ' .. grupo)
    end
    Cmd('Store Effect 1.' .. i .. '.*')
    ProgressSet(progress, i)
  end
  if merge then
    Cmd('Delete Group ' .. grupo)
  end
  Cmd('ClearAll')
  ProgressStop(progress)
end

return TakeSelection