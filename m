Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:51262 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbcARPXq (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:23:46 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:44:06 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [RFC PATCH v2 00/11] vfss: support for a common kernel file loader
Date: Mon, 18 Jan 2016 10:11:15 -0500
Message-Id: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
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

Changelog v2:
- Combined the "ima: measuring/appraising files read by the kernel" patches
with this patch set to simplify review.
- Split the "ima: measure and appraise kexec image and initramfs" patch to
separate IMA from the kexec changes.

The latest version of these patches can be found in the next-kernel-read-v2
branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

[1] Taken from Luis Rodriguez's wiki -
http://kernelnewbies.org/KernelProjects/common-kernel-loader

Mimi

Dmitry Kasatkin (3):
  ima: separate 'security.ima' reading functionality from collect
  ima: provide buffer hash calculation function
  ima: load policy using path

Mimi Zohar (8):
  vfs: define a generic function to read a file from the kernel
  ima: calculate the hash of a buffer using aynchronous hash(ahash)
  ima: define a new hook to measure and appraise a file already in
    memory
  kexec: replace call to copy_file_from_fd() with kernel version
  firmware: replace call to fw_read_file_contents() with kernel version
  module: replace copy_module_from_fd with kernel version
  ima: measure and appraise the IMA policy itself
  ima: require signed IMA policy

 Documentation/ABI/testing/ima_policy      |   2 +-
 drivers/base/firmware_class.c             |  48 ++++--------
 fs/exec.c                                 |  93 +++++++++++++++++++++++
 include/linux/fs.h                        |   3 +
 include/linux/ima.h                       |  17 ++++-
 include/linux/lsm_hooks.h                 |  19 +++++
 include/linux/security.h                  |  14 ++--
 kernel/kexec_file.c                       |  72 ++----------------
 kernel/module.c                           |  67 ++--------------
 security/integrity/iint.c                 |   1 +
 security/integrity/ima/ima.h              |  35 +++++----
 security/integrity/ima/ima_api.c          |  19 ++---
 security/integrity/ima/ima_appraise.c     |  45 +++++------
 security/integrity/ima/ima_crypto.c       | 120 ++++++++++++++++++++++++++++-
 security/integrity/ima/ima_fs.c           |  50 +++++++++++-
 security/integrity/ima/ima_init.c         |   2 +-
 security/integrity/ima/ima_main.c         |  52 +++++++++----
 security/integrity/ima/ima_policy.c       | 122 +++++++++++++++++++-----------
 security/integrity/ima/ima_template.c     |   2 -
 security/integrity/ima/ima_template_lib.c |   1 -
 security/integrity/integrity.h            |  14 ++--
 security/security.c                       |  46 +++++++----
 22 files changed, 540 insertions(+), 304 deletions(-)

-- 
2.1.0

