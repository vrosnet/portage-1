# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfind/kfind-4.3.3.ebuild,v 1.4 2009/11/30 06:54:51 josejx Exp $
EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDE file finder utility"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"
