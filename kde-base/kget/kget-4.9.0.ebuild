# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kget/kget-4.9.0.ebuild,v 1.1 2012/08/01 22:16:57 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug bittorrent mms semantic-desktop sqlite webkit"

RDEPEND="
	app-crypt/qca:2
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkonq)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep solid)
	bittorrent? ( >=net-libs/libktorrent-1.0.3 )
	mms? ( media-libs/libmms )
	sqlite? ( dev-db/sqlite:3 )
	webkit? ( >=kde-misc/kwebkitpart-0.9.6 )
"
DEPEND="${RDEPEND}
	dev-libs/boost
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with bittorrent KTorrent)
		$(cmake-utils_use_with mms LibMms)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with sqlite)
		$(cmake-utils_use_with webkit KWebKitPart)
	)
	kde4-meta_src_configure
}
