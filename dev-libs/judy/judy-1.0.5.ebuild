# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/judy/judy-1.0.5.ebuild,v 1.3 2010/04/04 18:34:14 armin76 Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="A C library that implements a dynamic array"
HOMEPAGE="http://judy.sourceforge.net/"
SRC_URI="mirror://sourceforge/judy/Judy-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${P}-parallel-make.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
