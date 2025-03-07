/mob/dead/observer/say(message)
	message = sanitize(copytext_char(message, 1, MAX_MESSAGE_LEN))

	if(!message)
		return

	client?.check_say_flood(5)
	return say_dead(message)


/mob/dead/observer/handle_track(message, verb = "says", mob/speaker = null, speaker_name, atom/follow_target, hard_to_hear)
	return "[speaker_name] ([ghost_follow_link(follow_target, ghost=src)])"


/mob/dead/observer/handle_speaker_name(mob/speaker = null, vname, hard_to_hear)
	var/speaker_name = ..()
	if(!speaker)
		return speaker_name
	//Announce computer and various stuff that broadcasts doesn't use it's real name but AI's can't pretend to be other mobs.
	if(isAI(speaker) || isAutoAnnouncer(speaker))
		return speaker_name
	speaker_name = "[speaker.real_name] ([speaker_name])"
	return speaker_name

