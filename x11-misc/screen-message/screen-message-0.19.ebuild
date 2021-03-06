# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screen-message/screen-message-0.19.ebuild,v 1.2 2012/05/15 18:30:06 sping Exp $

EAPI="2"

DESCRIPTION="Display a multi-line message large, fullscreen, black on white"
HOMEPAGE="http://www.joachim-breitner.de/projects#screen-message"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.10:2
	>=x11-libs/pango-1.16"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die

	dodir /usr/bin || die
	mv "${D}"/usr/{games,bin}/sm || die
	sed -i 's|Exec=/usr/games/sm||' "${D}"/usr/share/applications/sm.desktop || die
}
