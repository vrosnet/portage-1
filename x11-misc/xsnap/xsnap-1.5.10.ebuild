# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnap/xsnap-1.5.10.ebuild,v 1.1 2011/11/19 04:50:19 radhermit Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Program to interactively take a 'snapshot' of a region of the screen"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

COMMON_DEPEND="
	media-libs/libpng
	virtual/jpeg
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXpm
"
RDEPEND="${COMMON_DEPEND}
	media-fonts/font-misc-misc"
DEPEND="${COMMON_DEPEND}
	app-text/rman
	dev-lang/perl
	x11-misc/imake
	x11-proto/xproto"

DOCS=( AUTHORS Changelog README )

src_prepare() {
	xmkmf || die
	sed -i \
		-e '/ CC = /d' \
		-e '/ LD = /d' \
		-e '/ CDEBUGFLAGS = /d' \
		-e '/ CCOPTIONS = /d' \
		-e 's|CPP = cpp|CPP = $(CC)|g' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake CCOPTIONS="${CFLAGS}" EXTRA_LDOPTIONS="${LDFLAGS}"
}

src_install() {
	dodir /usr/share/man/man1
	default
}
