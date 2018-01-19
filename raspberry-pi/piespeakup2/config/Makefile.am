
dist_modulesload_DATA = speakup_soft.conf

nodist_piespeakup2unit_DATA = piespeakup2.service
nodist_piespeakup2unitconf_DATA = piespeakup2.conf

dist_piespeakup2restarttimer_DATA = piespeakup2restart.timer
dist_piespeakup2restartunit_DATA = piespeakup2restart.service

piespeakup2.service : piespeakup2.service.in
	$(SED) -e "s|prefix|$(prefix)|" $< > $@

piespeakup2.conf : piespeakup2.conf.in
	$(SED) "s|prefix|$(prefix)|" $< > $@



CLEANFILES = piespeakup2.service piespeakup2.conf


