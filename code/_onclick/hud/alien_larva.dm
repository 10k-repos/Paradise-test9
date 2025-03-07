/mob/living/carbon/alien/larva/create_mob_hud()
	if(client && !hud_used)
		hud_used = new /datum/hud/larva(src)

/datum/hud/larva/New(mob/owner)
	..()

	var/atom/movable/screen/using

	using = new /atom/movable/screen/act_intent/alien(null, src)
	using.icon_state = mymob.a_intent
	static_inventory += using
	action_intent = using

	using = new /atom/movable/screen/mov_intent(null, src)
	using.icon = 'icons/mob/screen_alien.dmi'
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	static_inventory += using
	move_intent = using

	mymob.healths = new /atom/movable/screen/healths/alien(null, src)
	infodisplay += mymob.healths

	nightvisionicon = new /atom/movable/screen/alien/nightvision(null, src)
	infodisplay += nightvisionicon

	mymob.pullin = new /atom/movable/screen/pull(null, src)
	mymob.pullin.icon = 'icons/mob/screen_alien.dmi'
	mymob.pullin.update_icon(UPDATE_ICON_STATE)
	mymob.pullin.screen_loc = ui_pull_resist
	hotkeybuttons += mymob.pullin

	using = new /atom/movable/screen/language_menu(null, src)
	using.screen_loc = ui_alienlarva_language_menu
	static_inventory += using

	zone_select = new /atom/movable/screen/zone_sel/alien(null, src)
	static_inventory += zone_select
