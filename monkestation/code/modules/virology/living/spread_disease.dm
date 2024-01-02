/mob/living
	///our immune system
	var/datum/immune_system/immune_system

/atom
	///image
	var/image/pathogen

/mob/living/proc/spread_airborne_diseases()
	//spreading our own airborne viruses
	if (diseases && diseases.len > 0)
		var/list/airborne_viruses = filter_disease_by_spread(diseases, required = DISEASE_SPREAD_AIRBORNE)
		if (airborne_viruses && airborne_viruses.len > 0)
			var/strength = 0
			for (var/datum/disease/advanced/V as anything in airborne_viruses)
				strength += V.infectionchance
			strength = round(strength/airborne_viruses.len)
			while (strength > 0)//stronger viruses create more clouds at once
				new /obj/effect/pathogen_cloud/core(get_turf(src), src, airborne_viruses)
				strength -= 40

/mob/living/carbon/infect_disease(datum/disease/advanced/disease, forced = FALSE, notes = "", decay = TRUE)
	if(!istype(disease))
		return FALSE

	if(!(disease.infectable_biotypes & mob_biotypes))
		return

	if(!disease.spread_flags)
		return FALSE

	for(var/datum/disease/advanced/D as anything in diseases)
		if("[disease.uniqueID]-[disease.subID]" == "[D.uniqueID]-[D.subID]") // child ids are for pathogenic mutations and aren't accounted for as thats fucked.
			return FALSE

	if(immune_system && !immune_system.CanInfect(disease))
		return FALSE

	if(prob(disease.infectionchance) || forced)
		var/datum/disease/advanced/D = disease.Copy()
		if (D.infectionchance > 5)
			D.infectionchance = max(5, D.infectionchance - 2)//The virus gets weaker as it jumps from people to people

		D.stage = clamp(D.stage+D.stage_variance, 1, D.max_stages)
		D.log += "<br />[ROUND_TIME()] Infected [key_name(src)] [notes]. Infection chance now [D.infectionchance]%"

		LAZYADD(diseases, D)
		D.affected_mob = src
		//SSdisease.active_diseases += D
		D.after_add()
		src.med_hud_set_status()

		log_virus("[key_name(src)] was infected by virus: [D.admin_details()] at [loc_name(loc)]")
		add_event_to_buffer(src,  data = "was infected by virus: [D.admin_details()] at [loc_name(loc)] Full Log: [D.log]", log_key = "VIRUS")

		D.AddToGoggleView(src)
	return TRUE
