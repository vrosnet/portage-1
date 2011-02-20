# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-sunpinyin/scim-sunpinyin-2.0.3.ebuild,v 1.1 2011/02/20 05:05:14 qiaomuf Exp $

EAPI="1"
inherit scons-utils

MY_P=${P/_/-}

DESCRIPTION="The SunPinyin IMEngine for Smart Common Input Method (SCIM)"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/scim
		app-i18n/sunpinyin
		x11-libs/gtk+:2 "
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	escons --prefix="/usr"
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install
}
