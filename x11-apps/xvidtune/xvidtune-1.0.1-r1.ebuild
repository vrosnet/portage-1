# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xvidtune/xvidtune-1.0.1-r1.ebuild,v 1.6 2009/04/09 15:03:52 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="video mode tuner for Xorg"

KEYWORDS="alpha amd64 arm ~mips ~ppc ~ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="x11-libs/libXxf86vm
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto"

CONFIGURE_OPTIONS="--disable-xprint"
