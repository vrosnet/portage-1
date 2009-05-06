# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/inputproto/inputproto-1.4.3-r1.ebuild,v 1.2 2009/05/05 15:13:15 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Input protocol headers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}"
IUSE=""
PATCHES=( "${FILESDIR}"/0001-C-sucks-define-XEventClass-in-terms-of-unsigned-int.patch
	"${FILESDIR}"/0002-Typo-fix.patch )
