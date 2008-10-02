# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Alien-wxWidgets/Alien-wxWidgets-0.34.ebuild,v 1.2 2008/09/30 07:52:27 tove Exp $

MODULE_AUTHOR=MBARBON
inherit perl-module wxwidgets

DESCRIPTION="Building, finding and using wxWidgets binaries"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="unicode"

SRC_TEST="do"

DEPEND="dev-lang/perl
	=x11-libs/wxGTK-2.6*
	>=dev-perl/module-build-0.26
	>=dev-perl/Module-Pluggable-3.1-r1"

perl-module_src_prep() {
	perlinfo

	WX_GTK_VER="2.6"

	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi

	echo no | perl Build.PL --installdirs=vendor \
		--destdir="${D}" \
		--libdoc= || die "perl Build.PL has failed!"
}
