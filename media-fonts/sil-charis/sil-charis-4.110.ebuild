# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-charis/sil-charis-4.110.ebuild,v 1.2 2012/05/27 12:28:17 yngwin Exp $

EAPI="4"

inherit font

MY_PN="CharisSIL"

DESCRIPTION="SIL Charis - SIL fonts for Roman and Cyrillic languages"
HOMEPAGE="http://scripts.sil.org/CharisSILfont"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.zip
	compact? ( mirror://gentoo/${MY_PN}Compact-${PV}.zip )"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="compact doc"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="OFL-FAQ.txt"

src_unpack() {
	unpack ${A}

	if use compact; then
		mv "${WORKDIR}"/${MY_PN}Compact-${PV}/*.${FONT_SUFFIX} "${FONT_S}" || die
	fi
}

src_install() {
	font_src_install
	use doc && dodoc -r "${S}"/documentation
}
