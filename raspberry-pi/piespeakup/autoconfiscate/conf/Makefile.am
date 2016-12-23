
piespeakup.service : piespeakup.service.in
	$(SED) -e 's|prefix|$(prefix)|' piespeakup.service.in > $@

	$(INSTALL) -m 0644 piespeakup.service /lib/systemd/system
	$(INSTALL) -m 0644 piespeakup.conf /etc/systemd/system
	$(INSTALL) -m 0644 speakup_soft_conf /etc/modules-load.d


CLEANFILES = piespeakup.service piespeakup.conf

