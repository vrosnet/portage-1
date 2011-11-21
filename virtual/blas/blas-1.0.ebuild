# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/blas/blas-1.0.ebuild,v 1.9 2011/11/21 15:30:58 jlec Exp $

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="|| (
		sci-libs/blas-reference
		>=sci-libs/blas-atlas-3.7.39
		>=sci-libs/mkl-9.1.023
		sci-libs/acml
		sci-libs/blas-goto
	)"
DEPEND=""
