# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-DBSchema/DBIx-DBSchema-0.38.ebuild,v 1.1 2010/01/17 10:39:23 tove Exp $

EAPI=2

MODULE_AUTHOR=IVAN
inherit perl-module

DESCRIPTION="Database-independent schema objects"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/DBI
	dev-perl/FreezeThaw
	virtual/perl-Storable"
DEPEND="${RDEPEND}"

SRC_TEST="do"
