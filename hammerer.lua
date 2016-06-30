-- script for telling a bank of ex compressum (or similar)
-- hammers which material to process. Will try to get an
-- even mix of gravel/sand/dust in the AE network.

-- the direction of the AE interface, relative to this computer
aeDirection = "left"

-- the cardinal direction of the chest relative to the interface
chestDirection = "south"

-- the size of the chest, smaller is better
chestSize = 1 -- tiny chest (measured in slots)

-- and that should be all that you need to edit!

-- what things you can hammer to get what, in case your pack is different
materials = {"cobble"}

local ae = peripheral.wrap(aeDirection)

-- empty the chest on startup
-- for i=1,chestSize do
--  ae.pullItem(chestDirection, i)
-- end

-- start main loop
while true do
 local contents = ae.getAvailableItems()
 
 local gravel = 0
 local sand   = 0
 local dust   = 0
 
 for item,value in pairs(contents) do
  if value["fingerprint"]["id"] == "ExtraUtilities:cobblestone_compressed" then
   if value["fingerprint"]["dmg"] == 12 then
    gravel = value["size"]
   elseif value["fingerprint"]["dmg"] == 14 then
    sand = value["size"]
   end
  elseif value["fingerprint"]["id"] == "excompressum:compressed_dust" then
   if value["fingerprint"]["dmg"] == 0 then
    dust = value["size"]
   end
  end
 end
 
 -- just for displaying, hammer perspective
 local export = " "
 -- from our perspective, aka the hammer input
 local exportType = "ExtraUtilities:cobblestone_compressed"
 local exportDmg = 0
 
 if gravel <= sand then
  if gravel <= dust then
   export = "gravel"
  else
   export = "dust"
   exportDmg = 14
  end
 else
  if sand <= dust then
   export = "sand"
   exportDmg = 12
  else
   export = "dust"
   exportDmg = 14
  end
 end
 
 ae.exportItem({id=exportType,dmg=exportDmg,}, chestDirection)
 
 term.clear()
 
 print("Gravel: "..gravel)
 print("Sand:   "..sand)
 print("Dust:   "..dust)
 print(" ")
 print("Creating: "..export)
 print(" ")
  
 sleep(1)
end
