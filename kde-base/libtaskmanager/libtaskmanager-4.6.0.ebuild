# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libtaskmanager/libtaskmanager-4.6.0.ebuild,v 1.1 2011/01/26 20:29:23 alexxy Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/taskmanager"
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/
	libs/kworkspace/
"
