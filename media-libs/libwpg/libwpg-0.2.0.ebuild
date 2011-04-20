# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwpg/libwpg-0.2.0.ebuild,v 1.1 2011/04/20 12:19:10 pacho Exp $

EAPI="4"

inherit autotools

DESCRIPTION="C++ library to read and parse graphics in WPG"
HOMEPAGE="http://libwpg.sourceforge.net/libwpg.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND=">=app-text/libwpd-0.9.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i -e 's: -Wall -Werror -pedantic::g' configure.in || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		$(use_with doc docs)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
