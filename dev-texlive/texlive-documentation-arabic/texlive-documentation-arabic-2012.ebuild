# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-arabic/texlive-documentation-arabic-2012.ebuild,v 1.1 2012/07/27 01:30:16 aballier Exp $

EAPI="4"

TEXLIVE_MODULE_CONTENTS="lshort-persian collection-documentation-arabic
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-persian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Arabic documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2012
"
RDEPEND="${DEPEND} "
