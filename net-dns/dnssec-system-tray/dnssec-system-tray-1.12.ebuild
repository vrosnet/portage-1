# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnssec-system-tray/dnssec-system-tray-1.12.ebuild,v 1.2 2012/05/24 15:08:11 mr_bones_ Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="display DNSSEC resolver logs in system tray"
HOMEPAGE="http://www.dnssec-tools.org"
SRC_URI="http://www.dnssec-tools.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake4 ${PN}.pro PREFIX=/usr
}

src_install() {
	qt4-r2_src_install

	newicon	images/justlock.png ${PN}.png
	make_desktop_entry ${PN}

	doman man/${PN}.1
}
