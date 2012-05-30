# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cgcode/cgcode-1.0-r2.ebuild,v 1.1 2012/05/30 08:59:54 jlec Exp $

EAPI=4

inherit eutils fortran-2 toolchain-funcs

DESCRIPTION="Conjugate gradient Codes for large sparse linear systems"
HOMEPAGE="http://fetk.org/codes/cgcode/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE=""

RDEPEND="
	virtual/fortran
	virtual/blas"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch

	cat >> make.inc <<- EOF
	F77 = $(tc-getFC)
	FFLAGS = ${FFLAGS}
	BLASLIBS = $(pkg-config --libs blas)
	EOF
}

src_install() {
	dobin goos good
	dolib.so src/lib${PN}.so*
	dodoc INTRODUCTION NOTE README
}
