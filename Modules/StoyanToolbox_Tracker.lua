function StoyanToolbox:WhenBoS()
    local nextBag = StoyanToolbox:CalculateNextBag() / 60

    if nextBag > 0 then
        print(nextBag .. " minutes BoS bag cooldown!")
    else
        print("You can get the bag!")
    end
end

function StoyanToolbox:BagUpdate()
    for bag=0,4 do
        for slot=0,GetContainerNumSlots(bag) do
           local link = GetContainerItemLink(bag, slot)
           if link ~= nil then
              local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(link)  
              local now = time()
              if sName == "Bloodhunter's Quarry" then
                self.db.global.bagLooted = now
              end
           end
        end
     end
end

function StoyanToolbox:CalculateNextBag()
    local bagLooted = self.db.global.bagLooted
    local now = time()

    local oneHourEpoch = 3600
    
    return (oneHourEpoch - (now - bagLooted))
end