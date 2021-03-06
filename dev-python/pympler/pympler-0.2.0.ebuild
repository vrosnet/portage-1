# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pympler/pympler-0.2.0.ebuild,v 1.2 2012/02/16 20:25:54 jlec Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="memory profiling for Python applications"
HOMEPAGE="http://code.google.com/p/pympler/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="Apache-2.0"
IUSE=""

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py test
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" run.py --test --clean
	}
	python_execute_function testing
}
