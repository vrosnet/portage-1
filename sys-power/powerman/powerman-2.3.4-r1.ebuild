# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powerman/powerman-2.3.4-r1.ebuild,v 1.2 2009/05/03 17:17:53 maekke Exp $

EAPI="1"

DESCRIPTION="RPC/PDU control and monitoring service for data center or compute cluster power management"
HOMEPAGE="http://powerman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+httppower +genders"
DEPEND="sys-devel/bison
		httppower? ( net-misc/curl )"
RDEPEND=">=sys-libs/freeipmi-0.2.3"

src_compile() {
	# Powerman stores the pidfile under $localstatedir/run.
	# It's set to /var/lib in the release, but in gentoo pidfiles live under /var/run.
	econf --localstatedir="/var" \
		$(use_with httppower) \
		$(use_with genders)
	emake || die
}

src_install() {
	emake DESTDIR="${D}" -j1 install || die
	rm -f "${D}/etc/init.d/powerman"
	doinitd "${FILESDIR}/powerman" || die
	dodoc AUTHORS ChangeLog DISCLAIMER NEWS TODO
}
