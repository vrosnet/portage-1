# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gentoo-PerlMod-Version/Gentoo-PerlMod-Version-0.2.1.ebuild,v 1.1 2011/01/11 07:17:33 tove Exp $

EAPI=3

MODULE_AUTHOR=KENTNL
inherit perl-module

DESCRIPTION="Convert arbitrary Perl Modules' versions into normalised Gentoo versions"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/List-MoreUtils
	dev-perl/Sub-Exporter
	>=virtual/perl-version-0.77
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.96
	)
"

SRC_TEST="do"
