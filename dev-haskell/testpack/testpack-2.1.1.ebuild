# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/testpack/testpack-2.1.1.ebuild,v 1.3 2012/01/24 15:39:34 tomka Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Test Utililty Pack for HUnit and QuickCheck"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/testpack"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND="dev-haskell/hunit
		dev-haskell/mtl
		>=dev-haskell/quickcheck-2.1.0.3
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"
