# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftui/giftui-0.4.1-r2.ebuild,v 1.1 2010/06/19 07:53:36 sochotnicky Exp $

inherit gnome2 eutils autotools

DESCRIPTION="A GTK+2 giFT frontend"
HOMEPAGE="http://giftui.sourceforge.net/"
SRC_URI="mirror://sourceforge/giftui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4.3
	net-p2p/gift
	>=gnome-base/gconf-2.6.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo-r1.patch"
	sed -i -e 's:/doc/giftui:/share/doc/${PF}:g' Makefile*

	eautoreconf
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR="${D}" install || die
}
