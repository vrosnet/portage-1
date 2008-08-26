# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libbonobo-python/libbonobo-python-2.22.1.ebuild,v 1.1 2008/08/24 07:32:05 ford_prefect Exp $

G_PY_PN="gnome-python"
G_PY_BINDINGS="bonobo bonoboui bonobo_activation"

inherit gnome-python-common

DESCRIPTION="Python bindings for the Bonobo framework"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-python/pyorbit-2.0.1
	>=gnome-base/libbonobo-2.8
	>=gnome-base/libbonoboui-2.8
	>=dev-python/libgnomecanvas-python-${PV}
	!<dev-python/gnome-python-2.22.1"
DEPEND="${RDEPEND}"

EXAMPLES="examples/bonobo/*
	examples/bonobo/bonoboui/
	examples/bonobo/echo/"
