mob/verb

    BasicAttack()
        name = "Basic Attack"
        icon_state = ""
        description = "Deals damage to a single melee target."
        animation = "attacking"
        cooldown = 40

mob
    proc
        can_use(mob/user)
            if(user.on_cooldown("melee-attack", "attack"))
                //This line causes the error ^
            return 0

            var/mob/target = user.melee_target()
            if(!target)
            user.no_target_selected(src)
            return 0

            return ..()

        effect(mob/user)

            var/mob/target = user.melee_target()

            user.cooldown("melee-attack", cooldown)
            user.cooldown("attack", 10)

            PhysicalCombat.attack(user, target, 5 + user.power)
            target.effect("dagger-slash")
            target.noise('hit-1.wav', frequency = rand(0.7, 1.3))