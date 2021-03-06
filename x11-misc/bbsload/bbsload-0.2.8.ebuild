# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.8.ebuild,v 1.16 2012/08/16 15:14:24 johu Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="blackbox load monitor"
HOMEPAGE="http://sourceforge.net/projects/bbtools/"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README AUTHORS BUGS ChangeLog NEWS TODO data/README.bbsload
}
