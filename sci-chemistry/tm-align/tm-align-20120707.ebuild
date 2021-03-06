# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/tm-align/tm-align-20120707.ebuild,v 1.1 2012/08/13 20:06:36 jlec Exp $

EAPI=4

inherit cmake-utils flag-o-matic fortran-2

DESCRIPTION="Quick & Accurate Structural Alignment"
HOMEPAGE="http://zhanglab.ccmb.med.umich.edu/TM-align/"
SRC_URI="http://zhanglab.ccmb.med.umich.edu/TM-align/TMtools${PV}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="static custom-cflags"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt . || die
	use static && append-fflags -static && append-ldflags -static
	# recommended by upstream
	use custom-cflags || replace-flags -O* -O3 && append-fflags -ffast-math
}
