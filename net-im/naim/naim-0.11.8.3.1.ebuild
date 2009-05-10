# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.8.3.1.ebuild,v 1.3 2009/05/09 20:13:29 gentoofan23 Exp $

DESCRIPTION="An ncurses based AOL Instant Messenger"
HOMEPAGE="http://naim.n.ml.org"
SRC_URI="http://naim.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug screen"

RESTRICT="test"

DEPEND=">=sys-libs/ncurses-5.2
		screen? ( app-misc/screen )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Alter makefile so firetalk-int.h is installed
	sed -i 's/include_HEADERS = firetalk.h/include_HEADERS = firetalk.h firetalk-int.h/' \
		libfiretalk/Makefile.am \
		libfiretalk/Makefile.in || die "Sed failed!"
}

src_compile() {
	# --enable-profile
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"
	use screen && myconf="${myconf} --enable-detach"

	econf \
		--with-pkgdocdir=/usr/share/doc/${PF} \
		${myconf}

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS FAQ BUGS README NEWS ChangeLog doc/*.hlp
}
