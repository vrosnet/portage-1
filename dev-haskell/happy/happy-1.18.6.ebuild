# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.18.6.ebuild,v 1.1 2011/08/02 10:15:09 slyfox Exp $

# ebuild generated by hackport 0.2.9

EAPI="3"

CABAL_FEATURES="bin"
inherit base haskell-cabal autotools

DESCRIPTION="Happy is a parser generator for Haskell"
HOMEPAGE="http://www.haskell.org/happy/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3
		>=dev-haskell/mtl-1.0
		>=dev-lang/ghc-6.8.2
		dev-lang/perl
		doc? (  ~app-text/docbook-xml-dtd-4.2
				app-text/docbook-xsl-stylesheets )"

PATCHES=("${FILESDIR}/${PN}-1.18.6-man.patch"
	"${FILESDIR}/${PN}-1.18.6-missing-tests.patch")

src_prepare() {
	base_src_prepare

	use doc && cd doc && eautoconf
}

src_configure() {
	cabal_src_configure

	use doc && cd doc && econf || die "econf failed in /doc"
}

src_compile() {
	cabal_src_compile

	use doc && cd doc && emake -j1 || die "emake failed in /doc"
}

src_test() {
	emake -C "${S}/tests/" || die "emake for tests failed"
}

src_install() {
	cabal_src_install
	if use doc; then
		cd doc
		dohtml -r happy/*
		doman "${S}/doc/happy.1"
	fi
}
