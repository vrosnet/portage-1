# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libtifiles2/libtifiles2-1.1.3.ebuild,v 1.1 2011/03/15 21:20:15 bicatali Exp $

EAPI=2

DESCRIPTION="Library for TI calculator files"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="mirror://sourceforge/tilp/tilp2-linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc nls static-libs"

RDEPEND="dev-libs/glib:2
	>=sci-libs/libticables2-1.1.3
	>=sci-libs/libticonv-1.1.1
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS LOGO NEWS README ChangeLog docs/api.txt
	if use doc; then
		dohtml docs/html/* || die
	fi
}
