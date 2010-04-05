# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lpe/lpe-1.2.6.13.ebuild,v 1.10 2010/04/05 04:10:05 abcd Exp $

EAPI="3"

inherit multilib

DESCRIPTION="a lightweight programmers editor"
HOMEPAGE="http://packages.qa.debian.org/l/lpe.html"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}-0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-linux"
IUSE="nls"

RDEPEND=">=sys-libs/slang-2.1.3"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake libdir="${ED}/usr/$(get_libdir)" \
		prefix="${ED}/usr" \
		datadir="${ED}/usr/share" \
		mandir="${ED}/usr/share/man" \
		infodir="${ED}/usr/share/info" \
		docdir="${ED}/usr/share/doc/${PF}" \
		exdir="${ED}/usr/share/doc/${PF}/examples" \
		install || die "emake install failed."
}
