# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf/hdf-4.2.8.ebuild,v 1.1 2012/08/15 16:09:09 xarthisius Exp $

EAPI=4
inherit eutils fortran-2 toolchain-funcs autotools flag-o-matic

MYP=${P/_p/-patch}

DESCRIPTION="General purpose library and format for storing scientific data"
HOMEPAGE="http://www.hdfgroup.org/hdf4.html"
SRC_URI="http://www.hdfgroup.org/ftp/HDF/HDF_Current/src/${MYP}.tar.bz2"

LICENSE="NCSA-HDF"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="fortran szip static-libs"

RDEPEND="virtual/jpeg
	sys-libs/zlib
	fortran? ( virtual/jpeg )
	szip? ( >=sci-libs/szip-2 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MYP}

src_prepare() {
	epatch "${FILESDIR}"/4.2.7_p1-autotools.patch
	sed -i -e 's/-R/-L/g' config/commence.am || die #rpath
	eautoreconf
	[[ $(tc-getFC) = *gfortran ]] && append-fflags -fno-range-check
}

src_configure() {
	econf \
		--enable-shared \
		--enable-production=gentoo \
		--disable-netcdf \
		$(use_enable fortran) \
		$(use_enable static-libs static) \
		$(use_with szip szlib) \
		CC="$(tc-getCC)"
}

src_install() {
	default
	dodoc release_notes/{RELEASE,HISTORY,bugs_fixed,misc_docs}.txt
	cd "${ED}"usr
	mv bin/ncgen{,-hdf} || die
	mv bin/ncdump{,-hdf} || die
	mv share/man/man1/ncgen{,-hdf}.1 || die
	mv share/man/man1/ncdump{,-hdf}.1 || die
}
