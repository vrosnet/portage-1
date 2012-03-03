# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-omega/texlive-omega-2011.ebuild,v 1.7 2012/03/03 13:58:43 ranger Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="antomega lambda mxedruli omega aleph omegaware collection-omega
"
TEXLIVE_MODULE_DOC_CONTENTS="antomega.doc mxedruli.doc omega.doc aleph.doc omegaware.doc "
TEXLIVE_MODULE_SRC_CONTENTS="antomega.source "
inherit  texlive-module
DESCRIPTION="TeXLive Omega"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
>=dev-texlive/texlive-latex-2011
>=dev-texlive/texlive-latex-2008
!<dev-texlive/texlive-fontsextra-2009
"
RDEPEND="${DEPEND} "
