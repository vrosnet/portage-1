# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubypants/rubypants-0.2.0-r1.ebuild,v 1.1 2009/12/16 22:05:49 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="test"

inherit ruby-fakegem

DESCRIPTION="A Ruby port of the SmartyPants PHP library."
HOMEPAGE="http://chneukirchen.org/blog/static/projects/rubypants.html"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

each_ruby_install() {
	ruby_fakegem_genspec

	ruby_fakegem_newins rubypants.rb lib/rubypants.rb
}
