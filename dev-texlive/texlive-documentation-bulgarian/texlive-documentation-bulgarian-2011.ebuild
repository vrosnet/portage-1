# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-bulgarian/texlive-documentation-bulgarian-2011.ebuild,v 1.6 2012/03/02 19:27:18 ranger Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-bulgarian pst-eucl-translation-bg collection-documentation-bulgarian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-bulgarian.doc pst-eucl-translation-bg.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Bulgarian documentation"

LICENSE="GPL-2 FDL-1.1 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
