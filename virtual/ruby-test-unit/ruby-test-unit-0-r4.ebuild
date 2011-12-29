# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-test-unit/ruby-test-unit-0-r4.ebuild,v 1.3 2011/12/29 15:26:23 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby ree18"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby test/unit library"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="ruby_targets_ruby18? ( dev-lang/ruby:1.8 )
	ruby_targets_ruby19? ( dev-lang/ruby:1.9 )
	ruby_targets_jruby? ( dev-java/jruby )
	ruby_targets_ree18? ( dev-lang/ruby-enterprise:1.8 )"
DEPEND=""
