# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fotowall/fotowall-0.8.2.ebuild,v 1.1 2009/09/20 17:55:19 spatz Exp $

EAPI="2"

inherit qt4

MY_P="${P/f/F}"

DESCRIPTION="Qt4 tool for creating wallpapers"
HOMEPAGE="http://www.enricoros.com/opensource/fotowall/"
SRC_URI="http://fotowall.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	opengl? ( x11-libs/qt-opengl:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	qt4_src_prepare

	if ! use opengl; then
		sed -i "/QT += opengl/d" "${PN}.pro" || die "sed failed"
	fi
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc "README.markdown" || die
}
