# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstyles/kstyles-4.8.1.ebuild,v 1.1 2012/03/06 23:35:26 dilfridge Exp $

EAPI=4

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep liboxygenstyle)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/oxygen
"
