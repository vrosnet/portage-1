# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/advancecomp/advancecomp-1.15.ebuild,v 1.9 2012/04/02 19:22:50 pacho Exp $

EAPI=4
inherit eutils

DESCRIPTION="Recompress ZIP, PNG and MNG using deflate 7-Zip, considerably improving compression"
HOMEPAGE="http://advancemame.sourceforge.net/comp-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~ppc64 x86 ~x86-fbsd"
IUSE="png mng"

DEPEND="sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}"

RESTRICT="test" #282441

src_prepare() {
	# bzip2 support wont compile, here's a quick patch.
	epatch "${FILESDIR}"/${PN}-1.13-bzip2-compile-plz-k-thx.diff
}

src_configure() {
	econf --enable-bzip2
}

src_install() {
	dobin advdef advzip

	if use png; then
		dobin advpng
		doman doc/advpng.1
	fi

	if use mng; then
		dobin advmng
		doman doc/advmng.1
	fi

	dodoc HISTORY AUTHORS README
	doman doc/advdef.1 doc/advzip.1
}
