# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-ICal/Date-ICal-2.678.0.ebuild,v 1.5 2012/03/02 22:01:58 ranger Exp $

EAPI=4

MODULE_AUTHOR=RBOW
MODULE_VERSION=2.678
inherit perl-module

DESCRIPTION="ICal format date base module for Perl"

SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Date-Leapyear
	virtual/perl-Time-Local
	virtual/perl-Time-HiRes
	virtual/perl-Storable"
DEPEND="${RDEPEND}"

SRC_TEST="do"
