# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pandoc/pandoc-1.9.3.ebuild,v 1.1 2012/06/02 09:49:45 gienah Exp $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="=dev-haskell/base64-bytestring-0.1*[profile?]
		=dev-haskell/blaze-html-0.5*[profile?]
		>=dev-haskell/blaze-markup-0.5.1[profile?]
		<dev-haskell/blaze-markup-0.6[profile?]
		>=dev-haskell/citeproc-hs-0.3.4[profile?]
		<dev-haskell/citeproc-hs-0.4[profile?]
		>=dev-haskell/highlighting-kate-0.5.0.2[profile?]
		<dev-haskell/highlighting-kate-0.6[profile?]
		>=dev-haskell/http-4000.0.5[profile?]
		<dev-haskell/http-4000.3[profile?]
		>=dev-haskell/json-0.4[profile?]
		<dev-haskell/json-0.6[profile?]
		>=dev-haskell/mtl-1.1[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/network-2[profile?]
		<dev-haskell/network-2.4[profile?]
		>=dev-haskell/pandoc-types-1.9.0.2[profile?]
		<dev-haskell/pandoc-types-1.10[profile?]
		=dev-haskell/parsec-3.1*[profile?]
		>=dev-haskell/random-1[profile?]
		<dev-haskell/random-1.1[profile?]
		>=dev-haskell/syb-0.1[profile?]
		<dev-haskell/syb-0.4[profile?]
		>=dev-haskell/tagsoup-0.12.5[profile?]
		<dev-haskell/tagsoup-0.13[profile?]
		=dev-haskell/temporary-1.1*[profile?]
		>=dev-haskell/texmath-0.6.0.2[profile?]
		<dev-haskell/texmath-0.7[profile?]
		>=dev-haskell/time-1.2[profile?]
		<dev-haskell/time-1.5[profile?]
		=dev-haskell/utf8-string-0.3*[profile?]
		>=dev-haskell/xml-1.3.12[profile?]
		<dev-haskell/xml-1.4[profile?]
		>=dev-haskell/zip-archive-0.1.1.7[profile?]
		<dev-haskell/zip-archive-0.2[profile?]
		=dev-haskell/zlib-0.5*[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.10
		test? ( dev-haskell/ansi-terminal[profile?]
			dev-haskell/diff[profile?]
			dev-haskell/hunit[profile?]
			dev-haskell/quickcheck:2[profile?]
			dev-haskell/test-framework-hunit[profile?]
			dev-haskell/test-framework-quickcheck2[profile?]
			dev-haskell/test-framework[profile?]
		)
		"

PATCHES=("${FILESDIR}/${PN}-1.9.3-ghc-7.5.patch")

src_configure() {
	cabal_src_configure \
		$(cabal_flag test tests)
}

src_install() {
	cabal_src_install

	doman "${S}/man/man1/${PN}.1"

	# COPYING is installed by the Cabal eclass
	dodoc README COPYRIGHT changelog
}
