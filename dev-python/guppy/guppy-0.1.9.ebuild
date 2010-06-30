# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/guppy/guppy-0.1.9.ebuild,v 1.3 2010/06/30 02:16:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Guppy-PE -- A Python Programming Environment"
HOMEPAGE="http://guppy-pe.sourceforge.net/ http://pypi.python.org/pypi/guppy"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="ANNOUNCE ChangeLog"

src_test() {
	testing() {
		cd "${S}"
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --home="${T}/test-${PYTHON_ABI}" || die "Installation of tests failed with Python ${PYTHON_ABI}"
		cd "${T}/test-${PYTHON_ABI}/lib/python"
		PYTHONPATH="$(ls -d "${S}/build-${PYTHON_ABI}/"lib*):." "$(PYTHON)" guppy/heapy/test/test_all.py || return 1
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml guppy/doc/*

	delete_duplicated_documentation() {
		find "${D}$(python_get_sitedir)" -name '*.html' -o -name '*.jpg' | xargs rm -f
	}
	python_execute_function -q delete_duplicated_documentation
}
