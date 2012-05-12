# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/casacore/casacore-1.4.0.ebuild,v 1.1 2012/05/11 21:51:50 bicatali Exp $

EAPI=4

inherit cmake-utils eutils toolchain-funcs fortran-2

DESCRIPTION="Core libraries for the Common Astronomy Software Applications"
HOMEPAGE="http://code.google.com/p/casacore/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc fftw hdf5 openmp threads test"

RDEPEND="sci-libs/cfitsio
	sci-astronomy/wcslib
	sys-libs/readline
	virtual/blas
	virtual/fortran
	virtual/lapack
	hdf5? ( sci-libs/hdf5 )
	fftw? ( >=sci-libs/fftw-3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}"/1.3.0-{implicits,libdir}.patch )

pkg_setup() {
	if [[ $(tc-getCC)$ == *gcc* ]] && ! tc-has-openmp; then
		ewarn "You are using gcc but without OpenMP capabilities"
		die "Need an OpenMP capable compiler"
	fi
	fortran-2_pkg_setup
}

src_configure() {
	has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	mycmakeargs+=(
		-DENABLE_SHARED=ON
		-DDATA_DIR="${EPREFIX}/usr/share/casacore/data"
		$(cmake-utils_use_build test TESTING)
		$(cmake-utils_use_use fftw FFTW3)
		$(cmake-utils_use_use hdf5 HDF5)
		$(cmake-utils_use_use threads THREADS)
		$(cmake-utils_use_use openmp OPENMP)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && doxygen doxygen.cfg
}

src_install(){
	cmake-utils_src_install
	use doc && dohtml -r doc/html
}
