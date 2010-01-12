# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-0.11.1.ebuild,v 1.14 2010/01/12 10:32:08 grobian Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A unittest extension offering automatic test suite discovery and easy test authoring"
HOMEPAGE="http://somethingaboutorange.com/mrl/projects/nose/ http://code.google.com/p/python-nose/ http://pypi.python.org/pypi/nose https://bitbucket.org/jpellerin/nose/"
SRC_URI="http://somethingaboutorange.com/mrl/projects/nose/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc examples test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )
	test? ( dev-python/twisted )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="AUTHORS"

src_prepare() {
	distutils_src_prepare

	# Disable tests and doc features that access the network
	epatch "${FILESDIR}/${PN}-0.10.0-tests-nonetwork.patch"
	epatch "${FILESDIR}/${PN}-0.11.0-disable_intersphinx.patch"

	epatch "${FILESDIR}/${P}-python-2.7.patch"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		mkdir -p .build/html .build/doctrees
		sphinx-build . html || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install --install-data "${EPREFIX}/usr/share"

	python_generate_wrapper_scripts -E -f -q "${D%/}${EPREFIX}/usr/bin/nosetests"

	if use doc; then
		dohtml -r -A txt doc/html/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
