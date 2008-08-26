# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwhois/gwhois-20080716.ebuild,v 1.6 2008/08/24 17:48:51 klausman Exp $

inherit eutils

MY_P=${P/_p/.}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="generic whois"
HOMEPAGE="http://gwhois.de/"
SRC_URI="http://gwhois.de/gwhois/${MY_P/-/_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE=""

RDEPEND="www-client/lynx
	net-misc/curl
	dev-lang/perl
	dev-perl/libwww-perl"

src_install() {
	dodir /etc/gwhois
	insinto /etc/gwhois
	doins pattern
	dobin gwhois
	doman gwhois.1
	dodoc TODO "${FILESDIR}/gwhois.xinetd" README.RIPE
	einfo ""
	einfo "See included gwhois.xinetd for an example on how to"
	einfo "use gwhois as a whois proxy using xinetd."
	einfo "Just copy gwhois.xinetd to /etc/xinetd.d/gwhois"
	einfo "and reload xinetd."
	einfo ""
}

pkg_postinst() {
	if [ -f /etc/gwhois/pattern.ripe ]; then
		ewarn ""
		ewarn "Will move old /etc/gwhois/pattern.ripe to removethis-pattern.ripe"
		ewarn "as it causes malfunction with this version."
		ewarn "If you did not modify the file, just remove it."
		ewarn ""
		mv /etc/gwhois/pattern.ripe /etc/gwhois/removethis-pattern.ripe
	fi
}
