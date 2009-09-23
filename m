Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tim Abbott <tabbott@ksplice.com>
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rusty@rustcorp.com.au, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, Tim Abbott <tabbott@ksplice.com>
Subject: [PATCH 0/2] Use generic binary search function
Date: Wed, 23 Sep 2009 13:28:44 -0400
Message-Id: <1253726926-5504-1-git-send-email-tabbott@ksplice.com>
In-Reply-To: <1253626718-18887-5-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1253626718-18887-5-git-send-email-alan-jenkins@tuffmail.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

> The builtin symbol tables are now sorted, so we can use a binary
> search.

Hi Alan,

There a large number hand-coded binary searches in the kernel (run
"git grep search | grep binary" to find many of them).  Since getting
binary searches right is difficult, I've been meaning to submit a
patch adding a lib/bsearch.c for some time now, so that we only have
to get binary search right in one place.

This patch series contains a generic binary search implementation as
well as something converting your module.c patch to use it.  I haven't
had a chance to boot-test yet, but this should give you a sense of
what this is going to look like.  To me, you take some somewhat
complex code and replace it with some very straightforward code.

This generic binary search implementation comes from Ksplice.  It has
the same basic API as the C library bsearch() function.  Ksplice uses
it in half a dozen places with 4 different comparison functions, and I
think our code is substantially cleaner because of this.

I don't claim that this is a perfect implementation of binary search,
though it is reasonably well tested.  My theory is that it is about as
good as all the hand-coded copies all over the kernel, and we can
optimize it to perfection later.

Tim Abbott (2):
  lib: Add generic binary search function to the kernel.
  module: use bsearch in find_symbol_in_kernel_section.

 include/linux/bsearch.h |    9 ++++++++
 kernel/module.c         |   34 +++++++++++++----------------
 lib/Makefile            |    2 +-
 lib/bsearch.c           |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/bsearch.h
 create mode 100644 lib/bsearch.c

