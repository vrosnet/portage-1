# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/crack/crack-0.1.8.ebuild,v 1.5 2011/04/09 12:19:37 graaff Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19 jruby ree18"

# workaround for ruby 1.9.2, sent upstream after 0.1.8
RUBY_FAKEGEM_TASK_TEST="-Ilib test"
RUBY_FAKEGEM_TASK_DOC="-Ilib rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc History"

inherit ruby-fakegem

DESCRIPTION="Really simple JSON and XML parsing, ripped from Merb and Rails."
HOMEPAGE="http://rubyforge.org/projects/crack"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/shoulda dev-ruby/matchy )"

all_ruby_prepare() {
	# By default this gem wants to use the fork of matchy from the
	# same author of itself, but we don't package that (as it's
	# neither released on gemcutter nor tagged). On the other hand it
	# works fine with the mcmire gem that we package as
	# dev-ruby/matchy.
	sed -i -e 's:jnunemaker-matchy:mcmire-matchy:' test/test_helper.rb || die
}
