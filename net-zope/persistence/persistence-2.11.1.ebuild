# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/persistence/persistence-2.11.1.ebuild,v 1.3 2010/01/16 18:57:47 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Persistence"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Persistent ExtensionClass"
HOMEPAGE="http://pypi.python.org/pypi/Persistence"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="net-zope/extensionclass
	net-zope/zodb"
DEPEND="${RDEPEND}
	test? ( dev-python/nose net-zope/zope-testing )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"

src_test() {
	testing() {
		local module
		for module in Persistence; do
			ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/_${module}.so" "src/${module}/_${module}.so" || die "Symlinking ${module}/_${module}.so failed with Python ${PYTHON_ABI}"
		done

		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Don't install sources.
	find "${D}"usr/$(get_libdir)/python*/site-packages -name "*.c" | xargs rm -f
}
