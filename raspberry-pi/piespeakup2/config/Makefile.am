
dist_modulesload_DATA = speakup_soft.conf
nodist_systemdunit_DATA = piespeakup2.service
nodist_piespeakupunitconf_DATA = piespeakup2.conf

piespeakup2.service : piespeakup2.service.in
	$(SED) -e "s|prefix|$(prefix)|" $< > $@

piespeakup2.conf : piespeakup2.conf.in
	$(SED) "s|prefix|$(prefix)|" $< > $@



CLEANFILES = piespeakup2.service piespeakup2.conf


