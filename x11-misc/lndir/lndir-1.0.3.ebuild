# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lndir/lndir-1.0.3.ebuild,v 1.5 2012/07/12 18:04:48 ranger Exp $

EAPI=3

XORG_STATIC=no
inherit xorg-2

DESCRIPTION="create a shadow directory of symbolic links to another directory tree"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		x11-proto/xproto"
