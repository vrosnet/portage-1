# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-apps/plasma-apps-4.3.3.ebuild,v 1.4 2009/11/30 06:54:30 josejx Exp $

EAPI="2"

KMNAME="kdebase-apps"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Additional Applets for Plasma"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"
