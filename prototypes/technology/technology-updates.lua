if angelsmods.addons.warehouses then
    if data.raw.tool["logistic-science-pack"] then
        bobmods.lib.tech.replace_science_pack("logistic-warehouses-3", "production-science-pack", "logistic-science-pack")
        bobmods.lib.tech.replace_science_pack("logistic-warehouses-4", "production-science-pack", "logistic-science-pack")
    end
end

local OV = angelsmods.functions.OV
OV.add_unlock("water-treatment-4", "hydro-plant-3")

if mods["Clowns-Extended-Minerals"] then 
OV.add_unlock("water-washing-3", "washing-plant-3")
end

if angelsmods.bioprocessing then
    OV.add_unlock("bio-processing-red", "algae-farm-3")
end