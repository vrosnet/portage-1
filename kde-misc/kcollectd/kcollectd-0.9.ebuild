# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcollectd/kcollectd-0.9.ebuild,v 1.2 2010/10/21 20:41:56 dilfridge Exp $

EAPI="2"

KDE_LINGUAS="de"
inherit kde4-base

DESCRIPTION="Simple KDE-based live data viewer for collectd"
HOMEPAGE="http://www.forwiss.uni-passau.de/~berberic/Linux/kcollectd.html"
SRC_URI="http://www.forwiss.uni-passau.de/~berberic/Linux/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost
	net-analyzer/rrdtool"
RDEPEND="${DEPEND}
	|| ( app-admin/collectd[collectd_plugins_rrdtool] app-admin/collectd[collectd_plugins_rrdcached] )"

src_prepare() {
	kde4-base_src_prepare

	find "${S}" -name "*.docbook" \
		-exec sed -i -r -e 's/DocBook XML V4\.1\.2-Based Variant/DocBook XML V4.2-Based Variant/g' {} + \
		|| die 'failed to fix DocBook variant version'
}
