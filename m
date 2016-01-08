Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:48142 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbcAHTXZ (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 14:23:25 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 05:23:22 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC PATCH 0/5] vfs: support for a common kernel file loader (step 1)
Date: Fri,  8 Jan 2016 14:21:59 -0500
Message-Id: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

For a while it was looked down upon to directly read files from Linux.
These days there exists a few mechanisms in the kernel that do just this
though to load a file into a local buffer. There are minor but important
checks differences on each, we should take all the best practices from
each of them, generalize them and make all places in the kernel that
read a file use it.[1]

One difference is the method for opening the file.  In some cases we
have a file, while in other cases we have a pathname or a file descriptor.

Another difference is the security hook calls, or lack of them.  In
some versions there is a post file read hook, while in others there
is a pre file read hook.

This patch set is the first attempt at resolving these differences.  It
does not attempt to merge the different methods of opening a file, but
defines a single common kernel file read function with two wrappers.
Although this patch set defines two new security hooks for pre and post
file read, it does not attempt to merge the existing security hooks.
That is left as future work.

These patches are based on top of the "ima: measuring/appraising files
read by the kernel".  The latest version of these patches can be found
in the next-kernel-read branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Mimi Zohar (5):
  vfs: define a generic function to read a file from the kernel
  firmware: replace call to fw_read_file_contents() with kernel version
  kexec: replace call to copy_file_from_fd() with kernel version
  ima: replace call to integrity_read_file() with kernel version
  module: replace copy_module_from_fd with kernel version

 drivers/base/firmware_class.c         | 51 +++++--------------
 fs/exec.c                             | 96 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h                    |  3 ++
 include/linux/ima.h                   |  7 +--
 include/linux/lsm_hooks.h             | 19 +++++++
 include/linux/security.h              | 14 +++--
 kernel/kexec_file.c                   | 76 +++------------------------
 kernel/module.c                       | 67 +++---------------------
 security/integrity/ima/ima.h          |  1 -
 security/integrity/ima/ima_appraise.c |  7 ---
 security/integrity/ima/ima_fs.c       | 15 +++---
 security/integrity/ima/ima_main.c     | 21 ++++----
 security/integrity/ima/ima_policy.c   | 16 +++---
 security/integrity/integrity.h        | 12 ++---
 security/security.c                   | 46 ++++++++++++-----
 15 files changed, 217 insertions(+), 234 deletions(-)

-- 
2.1.0

