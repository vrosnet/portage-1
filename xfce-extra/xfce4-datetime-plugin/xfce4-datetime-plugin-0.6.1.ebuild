# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-datetime-plugin/xfce4-datetime-plugin-0.6.1.ebuild,v 1.8 2012/05/05 07:10:45 mgorny Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plug-in with date, time and embedded calender"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-datetime-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.3.99.2
	>=xfce-base/libxfcegui4-4.3.99.2
	>=xfce-base/xfce4-panel-4.3.99.2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=( --disable-static )
	DOCS=( AUTHORS ChangeLog NEWS THANKS )
}

src_prepare() {
	sed -i -e '/Encoding/d' panel-plugin/datetime.desktop.in.in || die
	xfconf_src_prepare
}
