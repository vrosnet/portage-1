# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gigolo/gigolo-0.4.0-r1.ebuild,v 1.2 2010/05/23 17:46:38 pacho Exp $

EAPI="2"
EAUTORECONF="yes"
EINTLTOOLIZE="yes"
inherit xfconf

DESCRIPTION="a frontend to easily manage connections to remote filesystems using
GIO/GVfs"
HOMEPAGE="http://www.uvena.de/gigolo/index.html http://goodies.xfce.org/projects/applications/gigolo"
SRC_URI="mirror://xfce/src/apps/${PN}/0.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.16:2"
RDEPEND="${DEPEND}"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_install() {
	xfconf_src_install
	rm -rf "${D}"/usr/share/doc/${PN} || die "rm failed"
}
