# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-strigi-analyzer/kdepim-strigi-analyzer-4.8.3.ebuild,v 1.4 2012/05/24 08:48:31 ago Exp $

EAPI=4

KMNAME="kdepim"
KMMODULE="strigi-analyzer"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="kdepim: strigi plugins"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkleo/
	libkpgp/
	messageviewer/
"
