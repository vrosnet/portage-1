# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/qshare/qshare-2.1.3.ebuild,v 1.2 2012/04/10 14:29:36 pesa Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="FTP server with a service discovery feature"
HOMEPAGE="http://www.zuzuf.net/qshare/"
SRC_URI="http://www.zuzuf.net/qshare/files/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-dns/avahi[mdnsresponder-compat]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	# Respect CXXFLAGS, bug 411445
	sed -i -e '/^QMAKE_CXXFLAGS_RELEASE/d' ${PN}.pro || die

	qt4-r2_src_prepare
}

src_install() {
	dobin ${PN}
	doicon icons/${PN}.png
	make_desktop_entry /usr/bin/${PN} QShare ${PN} "Qt;Network;FileTransfer"
	dodoc AUTHORS README
}
