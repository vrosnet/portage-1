# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-4.9.0.ebuild,v 1.1 2012/08/01 22:16:48 johu Exp $

EAPI=4

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

KMEXTRA="
	HighResolutionWallpapers/
"
