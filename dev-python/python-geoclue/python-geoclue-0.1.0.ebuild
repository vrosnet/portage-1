# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-geoclue/python-geoclue-0.1.0.ebuild,v 1.5 2012/06/19 10:31:48 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 2.7-pypy-* *-jython"
PYTHON_MODNAME="Geoclue"

inherit distutils virtualx

DESCRIPTION="Geoclue python module"
HOMEPAGE="http://live.gnome.org/gtg/soc/python_geoclue/"
SRC_URI="http://www.paulocabido.com/soc/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"
IUSE="test"

RDEPEND="
	app-misc/geoclue
	dev-python/dbus-python"
DEPEND="test? ( app-misc/geoclue )"

S="${WORKDIR}"/${PN}

src_test() {
	testing() {
		VIRTUALX_COMMAND="$(PYTHON)"
		PYTHONPATH="build-${PYTHON_ABI}/lib" virtualmake tests/test.py
	}
	python_execute_function testing
}
