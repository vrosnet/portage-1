# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/duplicity/duplicity-0.6.17.ebuild,v 1.6 2012/06/09 15:38:15 jlec Exp $

EAPI="4"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Secure backup system using gnupg to encrypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://code.launchpad.net/${PN}/0.6-series/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="s3"

DEPEND="
	net-libs/librsync
	app-crypt/gnupg
"
RDEPEND="${DEPEND}
	>=dev-python/py-gnupg-0.3.2
	>=dev-python/pexpect-2.1
	s3? ( dev-python/boto )
"

src_prepare() {
	distutils_src_prepare
	sed -i -r "s/'COPYING',//" setup.py || die "Couldn't remove unnecessary COPYING file."
}
