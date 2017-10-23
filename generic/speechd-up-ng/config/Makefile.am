
nodist_systemdunit_DATA = speechd-up.service
nodist_speechdupunitconf_DATA = speechd-up.conf

speechd-up.service : speechd-up.service.in
	$(SED) -e "s|prefix|$(prefix)|" $< > $@

speechd-up.conf : speechd-up.conf.in
	$(SED) "s|prefix|$(prefix)|" $< > $@



CLEANFILES = speechd-up.service speechd-up.conf


