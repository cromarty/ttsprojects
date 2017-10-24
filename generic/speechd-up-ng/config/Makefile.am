
nodist_systemdunit_DATA = speechd-upd.service
nodist_speechdupunitconf_DATA = speechd-upd.conf

speechd-upd.service : speechd-upd.service.in
	$(SED) -e "s|prefix|$(prefix)|" $< > $@

speechd-upd.conf : speechd-upd.conf.in
	$(SED) "s|prefix|$(prefix)|" $< > $@



CLEANFILES = speechd-upd.service speechd-upd.conf


