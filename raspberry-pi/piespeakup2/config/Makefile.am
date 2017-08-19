
dist_modulesload_DATA = speakup_soft.conf
nodist_systemdunit_DATA = piespeakup.service
nodist_piespeakupunitconf_DATA = piespeakup.conf

piespeakup.service : piespeakup.service.in
	$(SED) -e "s|prefix|$(prefix)|" $< > $@

piespeakup.conf : piespeakup.conf.in
	$(SED) "s|prefix|$(prefix)|" $< > $@



CLEANFILES = piespeakup.service piespeakup.conf


