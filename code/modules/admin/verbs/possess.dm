/proc/possess(obj/O as obj in world)
	set name = "\[Admin\] Possess Obj"
	set category = null

	if(!check_rights(R_POSSESS))
		return

	if(istype(O,/obj/singularity))
		if(CONFIG_GET(flag/forbid_singulo_possession))
			to_chat(usr, "It is forbidden to possess singularities.")
			return

	var/turf/T = get_turf(O)

	var/confirm = alert("Are you sure you want to possess [O]?", "Confirm posession", "Yes", "No")

	if(confirm != "Yes")
		return
	log_and_message_admins("has possessed [O] ([O.type]) at [COORD(T)]")

	if(!usr.control_object) //If you're not already possessing something...
		usr.name_archive = usr.real_name

	usr.loc = O
	usr.real_name = O.name
	usr.name = O.name
	usr.client.eye = O
	usr.control_object = O
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Possess Object") //If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/proc/release(obj/O as obj in world)
	set name = "\[Admin\] Release Obj"
	set category = null
	//usr.loc = get_turf(usr)

	if(!check_rights(R_POSSESS))
		return

	if(usr.control_object && usr.name_archive) //if you have a name archived and if you are actually relassing an object
		usr.real_name = usr.name_archive
		usr.name = usr.real_name
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			H.name = H.get_visible_name()
//		usr.regenerate_icons() //So the name is updated properly

	usr.loc = O.loc // Appear where the object you were controlling is -- TLE
	usr.client.eye = usr
	usr.control_object = null
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Release Object") //If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
