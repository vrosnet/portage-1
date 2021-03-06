# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/libmpd/libmpd-0.7.2.ebuild,v 1.1 2012/04/13 21:10:59 slyfox Exp $

# ebuild generated by hackport 0.2.17.9999

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="An MPD client library."
HOMEPAGE="http://github.com/joachifm/libmpd-haskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/mtl-2.0*[profile?]
		>=dev-haskell/network-2.1[profile?] <dev-haskell/network-2.4[profile?]
		>=dev-haskell/time-1.1[profile?] <dev-haskell/time-2.0[profile?]
		>=dev-haskell/utf8-string-0.3.1[profile?] <dev-haskell/utf8-string-0.4[profile?]
		>=dev-lang/ghc-6.12.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
