# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xpr/xpr-1.0.4.ebuild,v 1.8 2012/07/12 17:23:24 ranger Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="X.Org xpr application"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""
RDEPEND="x11-libs/libXmu
	x11-libs/libX11"
DEPEND="${RDEPEND}"
