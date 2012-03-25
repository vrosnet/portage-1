# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openjpeg/openjpeg-1.5.0.ebuild,v 1.7 2012/03/25 14:51:10 ranger Exp $

EAPI=4
inherit cmake-utils multilib

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://code.google.com/p/openjpeg/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="doc test"

RDEPEND="media-libs/lcms:2
	media-libs/libpng:0
	media-libs/tiff:0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS CHANGES NEWS README THANKS )

PATCHES=( "${FILESDIR}"/${P}-build.patch )

RESTRICT="test" #409263

src_configure() {
	local mycmakeargs=(
		-DOPENJPEG_INSTALL_LIB_DIR="$(get_libdir)"
		$(cmake-utils_use_build doc)
		$(cmake-utils_use_build test TESTING)
		)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# See broken -E create_symlink(s) in the -build.patch!
	dosym openjpeg-1.5/openjpeg.h /usr/include/openjpeg.h
	dosym libopenjpeg1.pc /usr/$(get_libdir)/pkgconfig/libopenjpeg.pc
}
