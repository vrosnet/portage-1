# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-xmloutput/bzr-xmloutput-0.8.7.ebuild,v 1.4 2012/01/23 16:47:25 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

MY_P="${P}.final.0"

inherit distutils

DESCRIPTION="A Bazaar plugin that provides a option to generate XML output for
builtin commands."
HOMEPAGE="http://bazaar-vcs.org/XMLOutput"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-vcs/bzr"

S="${WORKDIR}/${MY_P}"
