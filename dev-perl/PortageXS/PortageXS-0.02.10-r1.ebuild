# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PortageXS/PortageXS-0.02.10-r1.ebuild,v 1.3 2011/01/18 22:20:29 xarthisius Exp $

inherit perl-module eutils prefix
DESCRIPTION="Portage abstraction layer for perl"
HOMEPAGE="http://download.mpsna.de/opensource/PortageXS/"
SRC_URI="http://download.mpsna.de/opensource/PortageXS/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="minimal"
SRC_TEST="do"

DEPEND="dev-lang/perl
	virtual/perl-Term-ANSIColor
	dev-perl/Shell-EnvImporter
	!minimal? ( dev-perl/IO-Socket-SSL
				virtual/perl-Sys-Syslog )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.02.09-prefix.patch
	eprefixify \
		lib/PortageXS/Core.pm \
		lib/PortageXS.pm \
		usr/bin/portagexs_client \
		usr/sbin/portagexsd

	if use minimal ; then
		rm -r "${S}"/usr
		rm -r "${S}"/etc/init.d
		rm -r "${S}"/etc/pxs/certs
		rm "${S}"/etc/pxs/portagexsd.conf
		rm -r "${S}"/lib/PortageXS/examples
	fi
}

pkg_preinst() {
	if use !minimal ; then
		cp -r "${S}"/usr "${D}${EPREFIX}"
	fi
	cp -r "${S}"/etc "${D}${EPREFIX}"
}

pkg_postinst() {
	if [ -d "${EPREFIX}"/etc/portagexs ]; then
		elog "${EPREFIX}/etc/portagexs has been moved to ${EPREFIX}/etc/pxs for convenience.  It is safe"
		elog "to delete old ${EPREFIX}/etc/portagexs directories."
	fi
}
