# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/grib_api/grib_api-1.9.16.ebuild,v 1.2 2012/08/03 19:09:41 bicatali Exp $

EAPI=4
inherit eutils autotools

#MYP=${P}_libtool
MYP=${P}

DESCRIPTION="Library for decoding WMO FM-92 GRIB messages"
HOMEPAGE="http://www.ecmwf.int/products/data/software/grib_api.html"
SRC_URI="http://www.ecmwf.int/products/data/software/download/software_files/${MYP}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples fortran jasper jpeg2k netcdf openmp png python static-libs"

DEPEND="
	jpeg2k? (
		jasper? ( media-libs/jasper )
		!jasper? ( media-libs/openjpeg )
	)
	netcdf? ( sci-libs/netcdf )
	png? ( media-libs/libpng )
	python? ( dev-python/numpy )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	sed -i -e 's:/usr/bin/ksh:/bin/sh:' tools/grib1to2.txt || die
	epatch \
		"${FILESDIR}"/${PN}-1.9.9-ieeefloat.patch \
		"${FILESDIR}"/${PN}-1.9.16-autotools.patch \
		"${FILESDIR}"/${PN}-1.9.16-jpeg2k.patch
	eautoreconf
}

src_configure() {
	# perl sources disappear from tar ball
	econf \
		--without-perl \
		$(use_enable jpeg2k jpeg) \
		$(
			use jasper && \
				echo --with-jasper=system --without-openjpeg || \
				echo --with-openjpeg=system --without-jasper
		) \
		$(use_enable fortran) \
		$(use_enable openmp omp-packing) \
		$(use_enable python) \
		$(use_enable python numpy) \
		$(use_enable static-libs static) \
		$(
			use netcdf && echo --with-netcdf="${EPREFIX}"/usr || \
				echo --with-netcdf=none
		) \
		$(use_with png png-support) \
		${myconf}
}

src_install() {
	default
	use doc && dohtml html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		emake clean
		doins -r *
	fi
}
