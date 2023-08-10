/datum/preference/choiced/goblin_ears
	savefile_key = "feature_goblin_ears"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Goblin Ears"
	should_generate_icons = TRUE

/datum/preference/choiced/goblin_ears/init_possible_values()
	return possible_values_for_sprite_accessory_list_for_body_part(
		GLOB.goblin_ears_list,
		"goblin_ears",
		list("ADJ", "FRONT"),
	)

/datum/preference/choiced/goblin_ears/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["goblin_ears"] = value


//Remove when eyes work with dwarfism
/datum/preference/choiced/goblin_eyes
	savefile_key = "feature_goblin_eyes"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Goblin Eyes"
	should_generate_icons = TRUE

/datum/preference/choiced/goblin_eyes/init_possible_values()
	return possible_values_for_sprite_accessory_list_for_body_part(
		GLOB.goblin_eyes,
		"goblin_eyes",
		list("FRONT"),
	)

/datum/preference/choiced/goblin_eyes/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["goblin_eyes"] = value
