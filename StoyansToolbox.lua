local frame, events = CreateFrame("Frame"), {};
function events:PLAYER_ENTERING_WORLD(...)
    
end

local profitButton = nil

function events:AUCTION_HOUSE_SHOW(...)
    if StoyansProfitButton == nil then
        local name = "StoyansProfitButton"
        local template = "UIPanelButtonTemplate"
        profitButton = CreateFrame("Button",name,AuctionHouseFrame,template) --frameType, frameName, frameParent, frameTemplate    
        profitButton:SetSize(80,20)
        profitButton:SetPoint("TOPRIGHT",-250,-37)
        profitButton.text = _G[name.."Text"]
        profitButton.text:SetText("Profit")

        profitButton:SetScript("OnClick", AHProfitInit)
     end
end

function AHProfitInit()
    profitButton:Disable()

    AHQueryForPrice

    
end

function AHQueryForPrice(itemID)
    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
    itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
    isCraftingReagent = GetItemInfo(itemID);

    local searchString = itemName
    local minLevel = nil
    local maxLevel = nil
    local filtersArray = nil
    local filterData = { classID = LE_ITEM_CLASS_CONTAINER, subClassID = nil, inventoryType = nil }
    local sorts = { sortOrder = Enum.AuctionHouseSortOrder.Price, reverseSort = false }
    
    
    local query = {};
    query.searchString = searchString;
    query.minLevel = minLevel;
    query.maxLevel = maxLevel;
    query.filters = filtersArray;
    query.itemClassFilters = filterData;
    query.sorts = sorts
    
    C_AuctionHouse.SendBrowseQuery(query)

    function events:AUCTION_HOUSE_BROWSE_RESULTS_UPDATED(...) 
        local browseResults = C_AuctionHouse.GetBrowseResults()

        local resultCount = table.getn(browseResults)

        local result = {};

        for i = 1, resultCount, 1
        do
            local browseResult = browseResults[i]
            local itemKey = browseResult["itemKey"]
            local ahItemID = itemKey["itemID"]
            local minPrice = browseResult["minPrice"]
   
            if ahItemID == itemID then
                
            end
        end
    end
end


frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end