
nodist_piespeakupldconfig_DATA = 01-libpiespeak.conf

01-libpiespeak.conf : 01-libpiespeak.conf.in
	$(SED) "s|prefix|$(prefix)|" $< > $@


CLEANFILES =01-libpiespeak.conf


