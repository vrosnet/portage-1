# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.8.1.ebuild,v 1.1 2012/03/06 23:35:11 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=app-misc/strigi-0.7.7[dbus,qt4]
	>=dev-libs/soprano-2.7.3[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	!kde-misc/nepomukcontroller
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# bug 392989
