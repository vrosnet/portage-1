# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-common-libs/kdepim-common-libs-4.8.3.ebuild,v 1.5 2012/05/24 08:45:17 ago Exp $

EAPI=4

KMNAME="kdepim"
KMNOMODULE="true"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="Common libraries for KDE PIM apps"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	>=app-office/akonadi-server-1.3.60
	>=dev-libs/shared-desktop-ontologies-0.6.50
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
	$(add_kdebase_dep kdepim-runtime)
"

# @Since >4.4.76 merged here
add_blocker akonadi
add_blocker libkdepim
add_blocker libkleo
add_blocker libkpgp
add_blocker kaddressbook '<4.4.90'
# kdepim-wizards removed since 4.8.0
add_blocker kdepim-wizards
add_blocker kmail '<4.4.80'
add_blocker korganizer '<4.5.67'

RESTRICT="test"
# bug 393131

KMEXTRA="
	akonadi_next/
	calendarsupport/
	calendarviews/
	incidenceeditor-ng/
	libkdepim/
	libkdepimdbusinterfaces/
	libkleo/
	libkpgp/
	kdgantt2/
	messagecomposer/
	messagecore/
	messagelist/
	messageviewer/
	ontologies/
	templateparser/
"

KMEXTRACTONLY="
	kleopatra/
	kmail/
	knode/org.kde.knode.xml
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
	korganizer/org.kde.korganizer.Korganizer.xml
"

KMSAVELIBS="true"

PATCHES=( "${FILESDIR}/${P}-qt47-compat.patch" )
