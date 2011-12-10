# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/e4rat/e4rat-0.2.1.ebuild,v 1.1 2011/12/10 11:48:12 hwoarang Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Toolset to accelerate the boot process and application startup"
HOMEPAGE="http://e4rat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-libs/boost-1.42[static-libs]
	sys-fs/e2fsprogs
	sys-process/audit"

RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE=release

src_prepare() {
	# do not hardcore boost version
	sed -i -e "/Boost/s:1.41:1.47:" CMakeLists.txt || die
	cmake-utils_src_prepare
}
