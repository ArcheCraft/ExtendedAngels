if not (mods["angelsaddons-storage"] and angelsmods.addons.storage.warehouses) then return end

local logistic_warehouses = {
	"warehouse-passive-provider",
	"warehouse-active-provider",
	"warehouse-buffer",
	"warehouse-storage",
	"warehouse-requester",
}

local prerequisite_map = {
	["angels-warehouse-passive-provider"] = "angels-warehouse",
	["angels-warehouse-active-provider"] = "angels-warehouse",
	["angels-warehouse-buffer"] = "angels-warehouse",
	["angels-warehouse-storage"] = "angels-warehouse",
	["angels-warehouse-requester"] = "angels-warehouse",

	["warehouse-mk2"] = "angels-warehouse",
	["warehouse-passive-provider-mk2"] = "angels-warehouse-passive-provider",
	["warehouse-active-provider-mk2"] = "angels-warehouse-active-provider",
	["warehouse-buffer-mk2"] = "angels-warehouse-buffer",
	["warehouse-storage-mk2"] = "angels-warehouse-storage",
	["warehouse-requester-mk2"] = "angels-warehouse-requester",

	["warehouse-mk3"] = "warehouse-mk2",
	["warehouse-passive-provider-mk3"] = "warehouse-passive-provider-mk2",
	["warehouse-active-provider-mk3"] = "warehouse-active-provider-mk2",
	["warehouse-buffer-mk3"] = "warehouse-buffer-mk2",
	["warehouse-storage-mk3"] = "warehouse-storage-mk2",
	["warehouse-requester-mk3"] = "warehouse-requester-mk2",

	["warehouse-mk4"] = "warehouse-mk3",
	["warehouse-passive-provider-mk4"] = "warehouse-passive-provider-mk3",
	["warehouse-active-provider-mk4"] = "warehouse-active-provider-mk3",
	["warehouse-buffer-mk4"] = "warehouse-buffer-mk3",
	["warehouse-storage-mk4"] = "warehouse-storage-mk3",
	["warehouse-requester-mk4"] = "warehouse-requester-mk3",
}

local standard_ingredients = {
	[1] = {
		{type = "item", name = "iron-plate", amount = 500},
		{type = "item", name = "stone-brick", amount = 100},
	},
	[2] = {
		{type = "item", name = mods["bobplates"] and "invar-alloy" or "angels-plate-nickel", amount = mods["bobplates"] and 400 or 300}, -- invar -> nickel, 400 -> 300
		{type = "item", name = mods["bobplates"] and "brass-gear-wheel" or "angels-plate-zinc", amount = mods["bobplates"] and 150 or 200}, -- brass -> zinc, 150 -> 200
		{type = "item", name = mods["bobplates"] and "steel-bearing" or "steel-plate", amount = mods["bobplates"] and 100 or 200}, -- Steel bearing -> plate, 100 -> 200
	},
	[3] = {
		{type = "item", name = mods["bobplates"] and "titanium-plate" or "angels-plate-titanium", amount = 800}, -- Use Angels Variant
		{type = "item", name = mods["bobplates"] and "ceramic-bearing" or "concrete-brick", amount = 200}, -- ceramic bearing -> concrete brick
	},
	[4] = {
		{type = "item", name = mods["bobplates"] and "tungsten-plate" or "angels-plate-tungsten", amount = 1000}, -- Use Angels Variant
		{type = "item", name = mods["bobplates"] and "nitinol-bearing" or "reinforced-concrete-brick", amount = 250}, -- nitinol bearing -> reinforced concrete brick
	}
}

local logistic_ingredients = {
	[1] = {
		{type = "item", name = "steel-plate", amount = 250},
		{type = "item", name = "electronic-circuit", amount = 100},
		{type = "item", name = "advanced-circuit", amount = 40},
	},
	[2] = {
		{type = "item", name = mods["bobplates"] and "invar-alloy" or "angels-plate-nickel", amount = mods["bobplates"] and 400 or 300}, -- invar -> nickel, 400 -> 300
		{type = "item", name = mods["bobplates"] and "brass-gear-wheel" or "angels-plate-zinc", amount = mods["bobplates"] and 150 or 200}, -- brass -> zinc, 150 -> 200
		{type = "item", name = mods["bobplates"] and "steel-bearing" or "steel-plate", amount = mods["bobplates"] and 100 or 200}, -- Steel bearing -> plate, 100 -> 200
	},
	[3] = {
		{type = "item", name = mods["bobplates"] and "titanium-plate" or "angels-plate-titanium", amount = 800}, -- Use Angels Variant
		{type = "item", name = mods["bobplates"] and "ceramic-bearing" or "concrete-brick", amount = 200}, -- ceramic bearing -> concrete brick
		{type = "item", name = "processing-unit", amount = 200},
	},
	[4] = {
		{type = "item", name = mods["bobplates"] and "tungsten-plate" or "angels-plate-tungsten", amount = 1000}, -- Use Angels Variant
		{type = "item", name = mods["bobplates"] and "nitinol-bearing" or "reinforced-concrete-brick", amount = 250}, -- nitinol bearing -> reinforced concrete brick
		{type = "item", name = mods["bobplates"] and "advanced-processing-unit" or "processing-unit", amount = mods["bobplates"] and 200 or 350},
	}
}

-- Revise Angel's warehouses
data.raw.recipe["angels-warehouse"].energy_required = 20
data.raw.recipe["angels-warehouse"].ingredients = util.copy(standard_ingredients[1])

for _, warehouse in pairs(logistic_warehouses)do
	data.raw.recipe["angels-"..warehouse].energy_required = 20
	data.raw.recipe["angels-"..warehouse].ingredients = util.copy(logistic_ingredients[1])
end

-- Iterate through warehouse types and make all the requisite recipes
for n = 2, 4 do
	-- Setup standard warehouse subtype
	data:extend({
		util.merge{data.raw.recipe["angels-warehouse"], {
			name = "warehouse-mk"..n,
			result = "warehouse-mk"..n,
			subgroup = "angels-warehouses-"..n,
		}}
	})

	data.raw.recipe["warehouse-mk"..n].ingredients = util.copy(standard_ingredients[n])

	-- Setup logistics warehouse subtypes
	for _, prefix in pairs(logistic_warehouses) do
		data:extend({
			util.merge{data.raw.recipe["angels-"..prefix], {
				name = prefix.."-mk"..n,
				result = prefix.."-mk"..n,
				subgroup = "angels-warehouses-"..n,
			}}
		})

		data.raw.recipe[prefix.."-mk"..n].ingredients = util.copy(logistic_ingredients[n])
	end
end

-- Add all the prerequisites
for name, prerequisite in pairs(prerequisite_map) do
    angelsmods.functions.OV.modify_input(name, {prerequisite, 1})
    angelsmods.functions.OV.execute()
end
