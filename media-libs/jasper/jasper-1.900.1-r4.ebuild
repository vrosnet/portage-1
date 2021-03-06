# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jasper/jasper-1.900.1-r4.ebuild,v 1.6 2012/04/26 21:10:33 aballier Exp $

EAPI=3

inherit libtool eutils

DESCRIPTION="software-based implementation of the codec specified in the JPEG-2000 Part-1 standard"
HOMEPAGE="http://www.ece.uvic.ca/~mdadams/jasper/"
SRC_URI="http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-${PV}.zip
	mirror://gentoo/${P}-fixes-20081208.patch.bz2"

LICENSE="JasPer2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="jpeg opengl static-libs"

RDEPEND="jpeg? ( virtual/jpeg )
	opengl? ( virtual/opengl media-libs/freeglut )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	epatch "${WORKDIR}"/${P}-fixes-20081208.patch
	epatch "${FILESDIR}"/CVE-2011-4516+7.patch
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable jpeg libjpeg) \
		$(use_enable opengl) \
		$(use_enable static-libs static) \
		--enable-shared
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README doc/*
	find "${ED}" -name '*.la' -delete
}
