# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ncp/ncp-1.2.4.ebuild,v 1.2 2012/05/24 15:08:39 mr_bones_ Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="utility for copying files in a LAN"
HOMEPAGE="http://www.fefe.de/ncp/"
SRC_URI="http://dl.fefe.de/ncp-1.2.4.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="diet"

RDEPEND=""
DEPEND="dev-libs/libowfat
	diet? ( dev-libs/dietlibc )"

src_prepare() {
	rm Makefile || die
	sed -e '/^ncp:/,+5s:strip:#strip:' \
		-i GNUmakefile || die
}

src_compile() {
	emake \
		CC="$(use diet && echo "diet -Os ")$(tc-getCC)" \
		CFLAGS="${CFLAGS} -I/usr/include/libowfat" \
		LDFLAGS="${LDFLAGS}" \
 		STRIP="#"
}

src_install() {
	dobin ncp
	dosym /usr/bin/ncp /usr/bin/npoll
	dosym /usr/bin/ncp /usr/bin/npush

	doman ncp.1 npush.1
	dodoc NEWS
}
