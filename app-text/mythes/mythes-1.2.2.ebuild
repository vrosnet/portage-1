# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mythes/mythes-1.2.2.ebuild,v 1.6 2012/05/04 03:33:18 jdhore Exp $

EAPI=4

DESCRIPTION="A simple thesaurus for Libreoffice"
HOMEPAGE="http://hunspell.sourceforge.net/"
SRC_URI="mirror://sourceforge/hunspell/MyThes/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND="app-text/hunspell"
DEPEND="${DEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
