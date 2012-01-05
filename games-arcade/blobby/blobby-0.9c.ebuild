# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blobby/blobby-0.9c.ebuild,v 1.3 2012/01/04 17:56:18 phajdan.jr Exp $

EAPI=2
inherit cmake-utils eutils games

DESCRIPTION="A beach ball game with blobs of goo"
HOMEPAGE="http://sourceforge.net/projects/blobby/"
SRC_URI="mirror://sourceforge/${PN}/${PN}2-linux-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-games/physfs-2[zip]
	media-libs/libsdl[audio,joystick,opengl,video,X]
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-beta-${PV}

src_prepare() {
	sed -i -e "s:share/${PN}:${GAMES_DATADIR}/${PN}:" data/CMakeLists.txt || die
	sed -i -e "s:share/${PN}:${GAMES_DATADIR/\/usr\/}/${PN}:" src/main.cpp || die
	sed -i -e "/DESTINATION/s:bin:${GAMES_BINDIR}:" src/CMakeLists.txt || die
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="AUTHORS ChangeLog README TODO" cmake-utils_src_install

	newicon data/Icon.bmp ${PN}.bmp
	make_desktop_entry ${PN} "Blobby Volley" /usr/share/pixmaps/${PN}.bmp

	prepgamesdirs
}
