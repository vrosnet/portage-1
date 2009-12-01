# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/parley/parley-4.3.3-r1.ebuild,v 1.4 2009/11/30 06:54:33 josejx Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE Educational: vocabulary trainer"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug +handbook +plasma"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kvtml-data)
"

KMEXTRACTONLY="
	libkdeedu/keduvocdocument
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma)"

	kde4-meta_src_configure
}
