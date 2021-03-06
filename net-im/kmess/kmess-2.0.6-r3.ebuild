# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-2.0.6-r3.ebuild,v 1.3 2011/11/17 18:51:51 phajdan.jr Exp $

EAPI=3

KDE_LINGUAS="ar ca de el es et fi fr gl hu it ja nl pt_BR ru sk tr zh_CN zh_TW"
inherit kde4-base

MY_P="${P/_/}"

DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux"
HOMEPAGE="http://www.kmess.org"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug gif konqueror libnotify xscreensaver"
RESTRICT="test"

COMMONDEPEND="
	app-crypt/qca:2
	app-crypt/qca-ossl:2
	dev-libs/libxml2
	dev-libs/libxslt
	gif? ( media-libs/giflib )
	konqueror? ( $(add_kdebase_dep libkonq) )
	libnotify? ( $(add_kdebase_dep knotify) )
	xscreensaver? ( x11-libs/libXScrnSaver )
"
DEPEND="${COMMONDEPEND}
	app-text/docbook-xml-dtd:4.2
	xscreensaver? ( x11-proto/scrnsaverproto )
"
RDEPEND="${COMMONDEPEND}
	konqueror? ( $(add_kdebase_dep konqueror) )
"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${P}-login-fix.patch
	"${FILESDIR}"/${P}-follow-location-redirects.patch
)

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gif GIF)
		$(cmake-utils_use_with konqueror LibKonq)
		$(cmake-utils_use_want xscreensaver XSCREENSAVER)"

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "KMess can use the following optional packages:"
	elog "- www-plugins/adobe-flash 	provides support for winks"
	echo
}
