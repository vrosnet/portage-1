# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pep8/pep8-1.0.1.ebuild,v 1.4 2012/06/02 15:24:35 xarthisius Exp $

EAPI=3

PYTHON_DEPEND="2:2.5 3:3.1"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python style guide checker"
HOMEPAGE="http://github.com/jcrocholl/pep8 http://pypi.python.org/pypi/pep8"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

PYTHON_MODNAME=${PN}.py

src_test() {

	test_func() {
		PYTHONPATH="${S}" "$(PYTHON)" ${PYTHON_MODNAME} -v --testsuite=testsuite
	}

	python_execute_function test_func
}
